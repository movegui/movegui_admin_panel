import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/establishment_category_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

class ProfessionnelModel extends EstablishmentModel {
  final List<String> professions;
  final CategoriesModel category;

  ProfessionnelModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.address,
    required super.email,
    required super.imageUrl,
    required super.phone,
    required super.weeklyHours,
    required super.establishmentType,
    required this.professions,
    required this.category,
    required super.isActive,
    required super.establishmentCategory,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'professions': professions,
    'category': category.toJson(),
  };

  factory ProfessionnelModel.fromJson(Map<String, dynamic> json) =>
      ProfessionnelModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        address: AdressModel.fromJson(json['adresse']),
        email: json['email'],
        phone: json['telephon'],
        category: CategoriesModel.fromJson(json['category']),
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map((e) => OpenHoursModel.fromJson(e))
            .toList(),
        establishmentType: EstablishmentType.values.firstWhere(
          (store) => store.name == (json['establishmentType'] as EstablishmentType).name,
          orElse: () => EstablishmentType.pressing,
        ),
        professions: (json['professions'] as List<String>),
        isActive: json['isActive'] as bool,
        establishmentCategory: EstablishmentCategoryModel.fromJson(json['establishmentCategory'])
      );

  @override
  String toString() {
    return 'Profession(name: $name, professions: ${professions[0].toString()},})';
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
