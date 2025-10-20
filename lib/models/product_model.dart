

import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/recipe_model.dart';

class ProductModel extends Model {
final String imageUrl;
final double price;
final List<RecipeModel> recipes;

  ProductModel({
    required super.id, 
    required super.name,
    required this.imageUrl,
    required this.price,
    required this.recipes
    });

    Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'recipes': recipes,

    };

    factory ProductModel.fromJson(Map<String, dynamic> json) =>  ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      recipes: json['recipes']
    );

  
}