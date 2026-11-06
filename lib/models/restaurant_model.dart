import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/establishment_category_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

class RestaurantModel extends EstablishmentModel {
  //  final RestaurantTypeModel restaurantType;

  RestaurantModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.imageUrl,
    required super.address,
    required super.email,
    required super.phone,
    required super.weeklyHours,
    required super.establishmentType,
    required super.isActive,
     required super.establishmentCategory,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    // 'restaurantType': sto.toJson(),
  };

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        address: AdressModel.fromJson(json['adresse']),
        email: json['email'],
        phone: json['telephon'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        establishmentType: EstablishmentType.values.firstWhere(
          (store) => store.name == (json['establishmentType'] as EstablishmentType).name,
          orElse: () => EstablishmentType.pressing,
        ),
        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map(
              (e) =>
                  (e != null &&
                      e['openTime'] != null &&
                      e['closeTime'] != null &&
                      e['day'] != null)
                  ? OpenHoursModel.fromJson(e)
                  : null,
            )
            .where((e) => e != null)
            .cast<OpenHoursModel>()
            .toList(),
        isActive: json['isActive'] as bool,
        establishmentCategory: EstablishmentCategoryModel.fromJson(json['establishmentCategory'])
      );
}

class RestaurantTypeModel extends Model {
  RestaurantTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory RestaurantTypeModel.fromJson(Map<String, dynamic> json) =>
      RestaurantTypeModel(
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
