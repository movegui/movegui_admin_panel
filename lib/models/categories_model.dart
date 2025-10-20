

import 'package:movegui_admin_panel/models/model.dart';

 class CategoriesModel extends Model{
  final DateTime createdAt;
  CategoriesModel({  required super.id, required super.name, required this.createdAt,}) ;

  
@override
  Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
  'createdAt': createdAt
};

factory CategoriesModel.fromJson(Map<String, dynamic> json)  {
  return CategoriesModel(
     id: json['id'],
   name: json['name'], 
   createdAt: json['createdAt'].toDate()
   );
}

String toString(){
  return id+' '+name!+' '+createdAt!.toString();
}
  
}


class CategoryIngredient extends CategoriesModel{
  CategoryIngredient({required super.id, required super.name, required super.createdAt});
  
}

class Categoryrecipe extends Model {
  Categoryrecipe({required super.id, required super.name});

  Map<String, dynamic> toJson() => {
  'id':id,
  'name': name,
};

factory Categoryrecipe.fromJson(Map<String, dynamic> json) => Categoryrecipe (
  id: json['id'],
  name: json['name']
  );
}

class CategoryRestaurant extends Model {
  final String imageUrl;
   final String description;

  CategoryRestaurant({
    required super.id,
     required super.name,
     required this.imageUrl,
     required this.description,
     });


  Map<String, dynamic> toJson() => {
    'id':id,
    'name': name,
};

factory CategoryRestaurant.fromJson(Map<String, dynamic> json) => CategoryRestaurant (
  id: json['id'],
  name: json['name'],
  imageUrl: json['imageurl'],
  description: json['description']
  );
  
}