import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
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
    required super.rating,
    required super.reviewCount,
    super.isComplete,
    super.isActive,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory PressingModel.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'];
    if (addressJson is! Map) {
      throw FormatException(
        'Missing or invalid "address" map in pressing "${json['id']}".',
      );
    }

    return PressingModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      address: AdressModel.fromJson(Map<String, dynamic>.from(addressJson)),
      email: json['email'],
      phone: json['telephon'],
      staff: (json['staff'] as List? ?? [])
          .map((e) => UserModel.fromJson(e))
          .toList(),
      createdAt: json['createdAt'] != null
          ? json['createdAt'].toDate()
          : DateTime.now(),
      weeklyHours: (json['weeklyHours'] as List? ?? [])
          .map((e) => OpenHoursModel.fromJson(e))
          .toList(),
      storeType: json['storeType'] != null
          ? RestaurantTypeModel.fromJson(json['storeType']) as StoreTypeModel
          : null,
      rating: json['rating'] ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      isComplete: json['isComplete'] is bool
          ? json['isComplete'] as bool
          : false,
      isActive: json['isActive'] is bool ? json['isActive'] as bool : false,
    );
  }
}
