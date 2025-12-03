import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
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
    required super.contacts,
    required super.weeklyHours,
    super.longitude,
    super.latitude,
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
        contacts: (json['contacts'] as List? ?? [])
            .map((e) => PersonModel.fromJson(e))
            .toList(),
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
        restaurantType: RestaurantTypeModel.fromJson(json['restaurantType']),
        longitude: json['longitude'],
        latitude: json['latitude'],
        weeklyHours: (json['weeklyHours'] as List? ?? [])
            .map((e) => OpenHours.fromJson(e))
            .toList(),
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
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
      );
      
        
          get description => null;
      
     

  @override
  String toString() {
    // TODO: implement toString
    return  'RestaurantModel(id: $id, name: $name, description: $description)';
  }

}
