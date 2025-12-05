import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class SuperMarktModel extends StoreModel {
  final CategoriesModel category;
  SuperMarktModel({
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
    required this.category,
    super.longitude,
    super.latitude

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
        contacts: (json['contacts'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
        weeklyHours: (json['weeklyHours'] as List? ?? []).map((e) => OpenHours.fromJson(e)).toList(),
         storeType: RestaurantTypeModel.fromJson(json['storeType']),
          category: CategoriesModel.fromJson(json['category']),
      );
}
