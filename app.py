import os
from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename
from models import db, Item, RecipeIngredient

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


# --- 3. ЗАПУСК (RUN) ---
if __name__ == '__main__':
    with app.app_context():
        # Создаем таблицы, если их еще нет
        db.create_all()
    app.run(debug=True)