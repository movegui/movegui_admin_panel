import 'package:movegui_admin_panel/models/model.dart';
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
    required super.adresse,
    required super.email,
    required super.telephon,
    required super.contacts,
    required super.weeklyHours,
    super.longitude,
    super.latitude,
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
        adresse: json['adresse'],
        email: json['email'],
        telephon: json['telephon'],
        contacts: (json['contacts'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        storeType: RestaurantTypeModel.fromJson(json['storeType']),
        longitude: json['longitude'],
        latitude: json['latitude'],

        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map(
              (e) => (e != null && e['openTime'] != null && e['closeTime'] != null && e['day'] != null)
                  ? OpenHours.fromJson(e)
                  : null,
            )
            .where((e) => e != null)
            .cast<OpenHours>()
            .toList(),

        /*
        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map((e) => (e.openTime != null && e.closeTime != null)? OpenHours.fromJson(e) : )
            .toList(),
            */
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
