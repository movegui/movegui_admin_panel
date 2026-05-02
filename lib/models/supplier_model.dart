

import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

  class SupplierModel extends StoreModel {

  SupplierModel({
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
    ...super.toJson()
  };

  factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      SupplierModel(
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
      );

}

/*
class SupplierIngredients extends SupplierModel {
  SupplierIngredients({
    required super.id,
     required super.name, 
     required super.createdAt,
     required super.adresse, 
     required super.telephon,
      required super.email, 
      required super.contact, 
      required super.company,
       required super.type});
  
      factory SupplierIngredients.fromJson(Map<String, dynamic> json) =>
      SupplierIngredients(
        id: json['id'],
        name: json['name'],
        adresse: json['adresse'],
        telephon: json['telephon'],
        email: json['email'],
        contact: json['contact'],
        company: json['company'],
        type: json['type'],
        createdAt: json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now()
      );

      @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
*/




