import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

class CompanyModel extends StoreModel {

  CompanyModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.email,
    required super.imageUrl,
    required super.phone,
    required super.staff,
    required super.weeklyHours,
    required super.storeType,
    required super.address, 
    required super.rating,
    required super.reviewCount
  });

    @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
  };

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      CompanyModel(
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
         storeType: json['storeType'] != null ? CompanyTypeModel.fromJson(json['storeType']) : null,
         rating: json['rating'] ?? 0.0,
         reviewCount: json['reviewCount'] ?? 0,
      );
}

class CompanyTypeModel extends StoreTypeModel {
  CompanyTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory CompanyTypeModel.fromJson(Map<String, dynamic> json) =>
      CompanyTypeModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
      );

  @override
  String toString() {
    // TODO: implement toString
    return 'RestaurantModel(id: $id, name: $name, createdAt: $createdAt)';
  }
}

