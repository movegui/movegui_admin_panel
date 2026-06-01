import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

class PatisserieModel extends StoreModel {
  final CategoriesModel category;
  PatisserieModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.address,
    required super.staff,
    required super.email,
    required super.imageUrl,
    required super.phone,
    required super.weeklyHours,
    required super.storeType,
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
        address: AdressModel.fromJson(json['adresse']),
        email: json['email'],
        phone: json['phone'],
        staff: (json['staff'] as List? ?? [])
            .map((e) => UserModel.fromJson(e))
            .toList(),
        category: CategoriesModel.fromJson(json['category']),
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
        weeklyHours: (json['weeklyHours'] as List? ?? []).map((e) => OpenHoursModel.fromJson(e)).toList(),
         storeType: RestaurantTypeModel.fromJson(json['storeType']),
      );
}
