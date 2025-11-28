import os
from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename
from models import db, Item  # Импортируем нашу базу и модели

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
    # Если просто открыли страницу
    if request.method == 'GET':
        return render_template('add_item.html')
    
    # Если нажали кнопку "Save"
    if request.method == 'POST':
        # Сбор данных из формы
        name = request.form.get('name')
        internal_name = request.form.get('internal_name')
        p_type = request.form.get('prototype_type')
        desc = request.form.get('description')
        stack = request.form.get('stack_size')
        time = request.form.get('crafting_time')
        
        # Обработка списка машин (строку превращаем в список)
        machines_str = request.form.get('produced_by')
        # Если строка не пустая, режем её по запятым, иначе пустой список
        machines_list = [m.strip() for m in machines_str.split(',')] if machines_str else []

        # Обработка картинки
        image_file = request.files['image']
        filename = 'default.png' 
        
        if image_file:
            safe_name = secure_filename(image_file.filename)
            # Убедись, что папка static/images существует!
            image_file.save(os.path.join(app.config['UPLOAD_FOLDER'], safe_name))
            filename = safe_name

        # Создаем объект
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
            db.session.commit()
            return redirect(url_for('index')) # Успех -> на главную
        except Exception as e:
            return f"Ошибка базы данных: {e}"


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