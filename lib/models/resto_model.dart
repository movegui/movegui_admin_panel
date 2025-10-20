

import 'package:movegui_admin_panel/models/model.dart';

class RestoModel extends Model {
  final String adresse, telephon, email, imageUrl;


  RestoModel({
     required super.id,
     required super.name, 
     required this.imageUrl,
     required this.adresse,
     required this.email,
     required this.telephon
    });

    Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'adresse': adresse,
      'email': email,
      'telephon': telephon
    };

    factory RestoModel.fromJson(Map<String, dynamic> json) => RestoModel (
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      adresse: json['adresse'],
      email: json['email'],
      telephon: json['telephon']
    );
}


class RestoCategory {
  final int id;
  final int restoId;
  final int categoryId;
  final DateTime createdAt;

  RestoCategory({
    required this.id,
    required this.categoryId,
    required this.restoId,
    required this.createdAt
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'restoId': restoId,
    'categoryId': categoryId
  };

  factory RestoCategory.fromJson(Map<String, dynamic> json) => RestoCategory(
    id: json['id'], 
    categoryId: json['categoryId'], 
    restoId: json['restoId'], 
    createdAt: json['createdAt']
    );
}
















