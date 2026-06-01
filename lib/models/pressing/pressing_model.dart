import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

class PressingModel extends StoreModel {
  PressingModel({
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
  });

    @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
  };

  factory PressingModel.fromJson(Map<String, dynamic> json) =>
      PressingModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        address: AdressModel.fromJson(json['address']),
        email: json['email'],
        phone: json['telephon'],
        staff: (json['staff'] as List? ?? [])
            .map((e) => UserModel.fromJson(e))
            .toList(),
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
        weeklyHours: (json['weeklyHours'] as List? ?? []).map((e) => OpenHoursModel.fromJson(e)).toList(),
         storeType: json['storeType'] != null ? RestaurantTypeModel.fromJson(json['storeType']) : null,
      );

}
