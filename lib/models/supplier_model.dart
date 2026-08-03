

import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

  class SupplierModel extends StoreModel {

  SupplierModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.imageUrl,
    required super.address,
    required super.email,
    required super.phone,
    required super.staff,
    required super.weeklyHours,
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
        address: AdressModel.fromJson(json['adresse']),
        email: json['email'],
        phone: json['telephon'],
        staff: (json['staff'] as List? ?? [])
            .map((e) => UserModel.fromJson(e))
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




