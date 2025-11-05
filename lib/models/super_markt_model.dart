import 'package:movegui_admin_panel/models/store_model.dart';

class SuperMarktModel extends StoreModel {
  SuperMarktModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.adresse,
    required super.contact,
    required super.email,
    required super.imageUrl,
    required super.telephon,

  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory SuperMarktModel.fromJson(Map<String, dynamic> json) =>
      SuperMarktModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
        description: json['description'],
        imageUrl: json['imageUrl'],
        adresse: json['adresse'],
        email: json['email'],
        telephon: json['telephon'],
        contact: json['contact'],
      );
}
