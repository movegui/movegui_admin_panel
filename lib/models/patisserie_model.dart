import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class PatisserieModel extends StoreModel {
  final CategoriesModel category;
  PatisserieModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.adresse,
    required super.contact,
    required super.email,
    required super.imageUrl,
    required super.telephon,
    required this.category,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'category': category.toJson(),
  };

  factory PatisserieModel.fromJson(Map<String, dynamic> json) =>
      PatisserieModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        adresse: json['adresse'],
        email: json['email'],
        telephon: json['telephon'],
        contact: json['contact'],
        category: CategoriesModel.fromJson(json['category']),
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now()
      );
}
