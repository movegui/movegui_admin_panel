
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/supplier_model.dart';

class IngredientModel extends Model {
  final double quantity, calories;
  final String unit;
  final bool isAllergic;
  final CategoryIngredient category;
  final SupplierIngredient supplier;
   final DateTime createdAt;

  IngredientModel({
    required super.id, 
    required super.name,
    required this.quantity,
    required this.calories,
    required this.unit,
    required this.isAllergic,
    required this.category,
    required this.supplier,
    required this.createdAt
    });

    Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
  'quantity': quantity,
  'calories': calories,
  'unit': unit,
  'isAllergic': isAllergic,
  'createdAt': createdAt,
  'category': category.toJson(),
  'supplier': supplier.toJson(),


};

factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel (
  id: json['id'],
  name: json['name'],
  quantity: json['quantity'],
  calories: json['calories'],
  unit: json['unit'],
  isAllergic: json['isAllergic'],
  category: CategoryIngredient.fromJson(json['category']),
  supplier: SupplierIngredient.fromJson(json['supplier']),
  createdAt: json['createdAt']
  );
    
}

/*

class Ingredient extends IngredientModel {
  final DateTime createdAt;
  final String imageurl;

  Ingredient({
    required super.id, 
    required super.name, 
    required super.quantity, 
    required super.calories,
    required super.unit, 
    required super.isAllergic, 
    required super.category, 
    required super.supplier,
    required this.createdAt,
    required this.imageurl
    });


}
*/