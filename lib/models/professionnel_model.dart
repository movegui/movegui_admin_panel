import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class ProfessionnelModel extends StoreModel {
  final List<String> professions;
  final CategoriesModel category;


  ProfessionnelModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.adresse,
    required super.contacts,
    required super.email,
    required super.imageUrl,
    required super.telephon,
    required super.weeklyHours,
    required super.storeType,
    required this.professions,
    required this.category,
    super.longitude,
    super.latitude,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'professions': professions,
    'category': category.toJson()
  };

  factory ProfessionnelModel.fromJson(Map<String, dynamic> json) =>
      ProfessionnelModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        adresse: json['adresse'],
        email: json['email'],
        telephon: json['telephon'],
        contacts: (json['contacts'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
        category: CategoriesModel.fromJson(json['category']),
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
        weeklyHours: (json['weeklyHours'] as List? ?? []).map((e) => OpenHours.fromJson(e)).toList(),
        storeType: RestaurantTypeModel.fromJson(json['storeType']),
         professions: (json['professions'] as List<String>) ,
  
      );

  @override
  String toString() {
    return 'Profession(name: $name, professions: ${professions[0].toString()}, persons: ${contacts.toList().toString()})';
  }
}

class ProfessionCategory {
  final int id;
  final String name;
  final List<String> subCategories;

  ProfessionCategory({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'subCategories': subCategories,
  };

  factory ProfessionCategory.fromJson(Map<String, dynamic> json) =>
      ProfessionCategory(
        id: json['id'],
        name: json['name'],
        subCategories: List<String>.from(json['subCategories']),
      );
}
