import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class RestaurantModel extends StoreModel {
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
    required super.contacts,
    required super.weeklyHours,
    required super.storeType,
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
        contacts: (json['contacts'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        storeType: RestaurantTypeModel.fromJson(json['storeType']),
        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map(
              (e) => (e != null && e['openTime'] != null && e['closeTime'] != null && e['day'] != null)
                  ? OpenHoursModel.fromJson(e)
                  : null,
            )
            .where((e) => e != null)
            .cast<OpenHoursModel>()
            .toList(),
      );
}

class RestaurantTypeModel extends StoreTypeModel {
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
