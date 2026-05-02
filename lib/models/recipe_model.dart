

import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/ingredient_model.dart';
import 'package:movegui_admin_panel/models/model.dart';

class RecipeModel extends Model {
  final String description;
  final Categoryrecipe category;
  final List<IngredientModel> ingredients;
  @override
  final DateTime createdAt;
  final double price;


  RecipeModel({
    required super.id, 
    required super.name,
    required this.description,
    required this.category,
    required this.ingredients,
    required this.createdAt,
    required this.price
    });

    factory  RecipeModel.fromJson(Map<String, dynamic> json) {
      return RecipeModel(
        id: json['id'], 
        name: json['name'], 
        description: json['description'],
        category: json['category'], 
        ingredients: json['ingredients'],
        createdAt: json['createdAt'],
        price: json['price']
        );
    }

    @override
  Map<String, dynamic> toJson() {
      return {
        'name': name,
        'description': description,
        'category': category,
        'ingredients': ingredients,
        'createdAt': createdAt,
        'price': price
      };
    }





}


