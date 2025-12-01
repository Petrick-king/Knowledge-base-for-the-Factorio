import os
from flask import Flask, render_template, request, redirect, url_for, jsonify
from werkzeug.utils import secure_filename
from models import db, Item, RecipeIngredient
from sqlalchemy import or_

app = Flask(__name__)

# --- 1. НАСТРОЙКИ (CONFIG) ---

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+pg8000://postgres:12345678@localhost/factorio_kb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Папка для загрузки картинок
UPLOAD_FOLDER = 'static/images'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Инициализация базы данных
db.init_app(app)

# --- 2. МАРШРУТЫ (ROUTES) ---

@app.route('/')
def index():
    # Получаем строку поиска (если есть)
    search_query = request.args.get('q')

    if search_query:
        # Ищем предметы, где имя похоже на запрос 
        items = Item.query.filter(Item.name.ilike(f'%{search_query}%')).all()
    else:
        # Если поиска нет, показываем всё
        items = Item.query.all()

    # Передаем список items в шаблон index.html
    return render_template('index.html', items=items)


@app.route('/add', methods=['GET', 'POST'])
def add_item():
    if request.method == 'GET':
        # Загружаем список всех предметов, чтобы выбирать из них ингредиенты
        all_items = Item.query.order_by(Item.name).all()
        return render_template('add_item.html', existing_items=all_items)
    
    if request.method == 'POST':
        # 1. Основные данные
        name = request.form.get('name')
        internal_name = request.form.get('internal_name')
        p_type = request.form.get('prototype_type')
        desc = request.form.get('description')
        stack = request.form.get('stack_size')
        time = request.form.get('crafting_time')
        
        machines_str = request.form.get('produced_by')
        machines_list = [m.strip() for m in machines_str.split(',')] if machines_str else []

        image_file = request.files['image']
        filename = 'default.png'
        
        if image_file:
            safe_name = secure_filename(image_file.filename)
            image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], safe_name))
            filename = safe_name

        # 2. Создаем сам предмет
        new_item = Item(
            name=name,
            internal_name=internal_name,
            prototype_type=p_type,
            description=desc,
            stack_size=int(stack) if stack else 50,
            crafting_time=float(time) if time else 0.5,
            produced_by=machines_list,
            image_filename=filename
        )

        try:
            db.session.add(new_item)
            db.session.commit() # Сначала сохраняем предмет, чтобы получить его ID!

            # 3. Обработка РЕЦЕПТА (Ингредиенты)
            # Мы получаем списки ID и количеств
            ingredient_ids = request.form.getlist('ingredient_id[]')
            ingredient_amounts = request.form.getlist('ingredient_amount[]')

            # Проходимся по списку и добавляем связи
            for i in range(len(ingredient_ids)):
                ing_id = ingredient_ids[i]
                amount = ingredient_amounts[i]

                # Если выбрали предмет и указали количество
                if ing_id and amount:
                    recipe_link = RecipeIngredient(
                        product_id=new_item.id,      # Что крафтим (наш новый предмет)
                        ingredient_id=int(ing_id),   # Из чего (ID ингредиента)
                        amount=float(amount)         # Сколько
                    )
                    db.session.add(recipe_link)
            
            db.session.commit() # Сохраняем рецепты
            return redirect(url_for('index'))

        except Exception as e:
            db.session.rollback() # Если ошибка - отменяем запись
            return f"При сохранении произошла ошибка: {e}"

# Маршрут для редактирования
@app.route('/edit/<int:item_id>', methods=['GET', 'POST'])
def edit_item(item_id):
    item = Item.query.get_or_404(item_id)
    
    # 1. ОТКРЫТИЕ СТРАНИЦЫ (GET)
    if request.method == 'GET':
        # Нам нужны все предметы для выпадающего списка ингредиентов
        all_items = Item.query.order_by(Item.name).all()
        return render_template('edit_item.html', item=item, existing_items=all_items)
    
    # 2. СОХРАНЕНИЕ ИЗМЕНЕНИЙ (POST)
    if request.method == 'POST':
        # Обновляем простые поля
        item.name = request.form.get('name')
        item.internal_name = request.form.get('internal_name')
        item.prototype_type = request.form.get('prototype_type')
        item.description = request.form.get('description')
        
        stack = request.form.get('stack_size')
        item.stack_size = int(stack) if stack else 0
        
        time = request.form.get('crafting_time')
        item.crafting_time = float(time) if time else 0.0
        
        machines_str = request.form.get('produced_by')
        item.produced_by = [m.strip() for m in machines_str.split(',')] if machines_str else []

        # Обновляем картинку ТОЛЬКО если загрузили новую
        image_file = request.files['image']
        if image_file:
            safe_name = secure_filename(image_file.filename)
            image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], safe_name))
            item.image_filename = safe_name

        try:
            # --- ОБНОВЛЕНИЕ РЕЦЕПТА ---
            # Самый простой способ: удалить старые ингредиенты и записать новые
            RecipeIngredient.query.filter_by(product_id=item.id).delete()
            
            # Считываем новые данные из формы
            ingredient_ids = request.form.getlist('ingredient_id[]')
            ingredient_amounts = request.form.getlist('ingredient_amount[]')

            for i in range(len(ingredient_ids)):
                ing_id = ingredient_ids[i]
                amount = ingredient_amounts[i]
                if ing_id and amount:
                    # Важно: нельзя добавить самого себя в рецепт (бесконечный цикл)
                    if int(ing_id) != item.id: 
                        new_link = RecipeIngredient(
                            product_id=item.id,
                            ingredient_id=int(ing_id),
                            amount=float(amount)
                        )
                        db.session.add(new_link)
            
            db.session.commit()
            return redirect(url_for('wiki_page', item_id=item.id))
            
        except Exception as e:
            db.session.rollback()
            return f"Ошибка при обновлении: {e}"

@app.route('/wiki/<int:item_id>')
def wiki_page(item_id):
    item = Item.query.get_or_404(item_id)
    return render_template('item.html', item=item)

@app.route('/api/search')
def search_api():
    query_text = request.args.get('q', '').strip()
    
    if not query_text:
        return jsonify([])

    words = query_text.split()
    
    # 1. Формируем запрос (как и раньше)
    search_query = Item.query
    for word in words:
        pattern = f"%{word}%"
        search_query = search_query.filter(
            or_(
                Item.name.ilike(pattern),
                Item.internal_name.ilike(pattern),
                Item.description.ilike(pattern),
                Item.prototype_type.ilike(pattern)
            )
        )
    
    # 2. Получаем побольше результатов (например 50), чтобы было что сортировать
    # Если мы возьмем мало (limit 5), может получиться так, что база вернет 5 предметов по описанию,
    # а предмет с нужным именем был бы 6-м и не попал в выборку.
    results = search_query.limit(50).all()

    # 3. УМНАЯ СОРТИРОВКА (Python)
    # Мы присваиваем каждому предмету "вес" (приоритет). Чем меньше число, тем выше предмет.
    def get_priority(item):
        name_lower = item.name.lower()
        q_lower = query_text.lower()
        
        # Приоритет 0: Полное совпадение фразы в начале названия (Идеально)
        if name_lower.startswith(q_lower):
            return 0
        
        # Приоритет 1: Полное совпадение фразы где-то в названии
        if q_lower in name_lower:
            return 1
            
        # Приоритет 2: Все слова запроса есть в названии (в любом порядке)
        # Например: ищем "plate iron", а предмет "Iron plate"
        all_words_in_name = all(w.lower() in name_lower for w in words)
        if all_words_in_name:
            return 2
            
        # Приоритет 3: Хотя бы одно слово есть в названии
        any_word_in_name = any(w.lower() in name_lower for w in words)
        if any_word_in_name:
            return 3
            
        # Приоритет 4: Совпадение только в описании/категории (самый низ)
        return 4

    # Сортируем список results, используя нашу функцию приоритета
    results.sort(key=get_priority)

    # 4. Теперь берем только топ-10 или топ-20 лучших
    final_results = results[:15]

    # 5. Упаковываем в JSON
    data = []
    for item in final_results:
        short_desc = (item.description[:100] + '...') if item.description and len(item.description) > 100 else (item.description or '')
        
        data.append({
            'id': item.id,
            'name': item.name,
            'image': item.image_filename,
            'description': short_desc
        })
    
    return jsonify(data)
    query_text = request.args.get('q', '').strip()
    
    if not query_text:
        return jsonify([])

    # 1. Разбиваем запрос пользователя на отдельные слова
    # "iron plate" -> ["iron", "plate"]
    words = query_text.split()

    # Начинаем формировать запрос к базе
    search_query = Item.query

    # 2. Магия: Проходим по КАЖДОМУ слову и добавляем фильтр
    for word in words:
        pattern = f"%{word}%" # %слово%
        
        # Слово должно быть ХОТЯ БЫ В ОДНОМ из этих полей:
        search_query = search_query.filter(
            or_(
                Item.name.ilike(pattern),           # В названии
                Item.internal_name.ilike(pattern),  # Во внутреннем ID
                Item.description.ilike(pattern),    # В описании
                Item.prototype_type.ilike(pattern),       # В категории
                Item.prototype_type.ilike(pattern)  # В типе
            )
        )
    
    # 3. Получаем результаты (максимум 20, чтобы список не был бесконечным)
    results = search_query.limit(20).all()

    # 4. Превращаем в JSON
    data = []
    for item in results:
        # Для описания берем первые 100 символов, чтобы не забивать поиск текстом
        short_desc = (item.description[:100] + '...') if item.description and len(item.description) > 100 else (item.description or '')
        
        data.append({
            'id': item.id,
            'name': item.name,
            'image': item.image_filename,
            'description': short_desc
        })
    
    return jsonify(data)

# --- 3. ЗАПУСК (RUN) ---
if __name__ == '__main__':
    with app.app_context():
        # Создаем таблицы, если их еще нет
        db.create_all()
    app.run(debug=True)