import 'package:movegui_admin_panel/models/model.dart';

abstract class StoreModel extends Model {

  final String adresse, telephon, email, imageUrl, contact, description;

  StoreModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.description,
    required this.adresse,
    required this.contact,
    required this.email,
    required this.imageUrl,
    required this.telephon,
  
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'adresse': adresse,
    'contact': contact,
    'email': email,
    'imageUrl': imageUrl,
    'telephon': telephon,
    
  };


/*
      factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel (
      id: json['id'],
      name: json['name'],
      description: json['description'],
      adresse: json['adresse'],
      contact: json['contact'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      telephon: json['telephon'],
    );
    */

}
