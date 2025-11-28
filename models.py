from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.dialects.postgresql import JSON

db = SQLAlchemy()

# --- ТАБЛИЦА РЕЦЕПТОВ ---
class RecipeIngredient(db.Model):
    __tablename__ = 'recipe_ingredients'
    
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.Integer, db.ForeignKey('items.id'), nullable=False)
    ingredient_id = db.Column(db.Integer, db.ForeignKey('items.id'), nullable=False)
    amount = db.Column(db.Float, default=1.0) 
    ingredient = db.relationship('Item', foreign_keys=[ingredient_id])


# --- ТАБЛИЦА ПРЕДМЕТОВ ---
class Item(db.Model):
    __tablename__ = 'items'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True) # Название 
    internal_name = db.Column(db.String(100))                     # Внутр. имя 
    prototype_type = db.Column(db.String(50), default='item')     # Тип 
    description = db.Column(db.Text)                              # Описание     
    stack_size = db.Column(db.Integer, default=50)                # Стак
    crafting_time = db.Column(db.Float, default=0.5)              # Время крафта     
    image_filename = db.Column(db.String(100), default='default.png')
    produced_by = db.Column(JSON, default=[]) 

    # Позволяет получить список ингредиентов через: item.recipe_ingredients
    recipe_ingredients = db.relationship(
        'RecipeIngredient',
        foreign_keys=[RecipeIngredient.product_id],
        backref='product',
        lazy=True
    )

    # Позволяет получить список предметов, куда нужен этот ресурс, через: item.used_in
    used_in = db.relationship(
        'RecipeIngredient',
        foreign_keys=[RecipeIngredient.ingredient_id],
        backref='usage',
        lazy=True
    )

    def __repr__(self):
        return f'<Item {self.name}>'