import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class RestaurantModel extends StoreModel {
  final RestaurantTypeModel restaurantType;

  RestaurantModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.imageUrl,
    required super.adresse,
    required super.email,
    required super.telephon,
    required super.contact,
    required this.restaurantType,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'restaurantType': restaurantType.toJson(),
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
        contact: json['contact'],
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
        restaurantType: RestaurantTypeModel.fromJson(json['restaurantType']),
      );
}

class RestaurantTypeModel extends Model {

  RestaurantTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt,
  };

  factory RestaurantTypeModel.fromJson(Map<String, dynamic> json) =>
      RestaurantTypeModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now()
      );
}
