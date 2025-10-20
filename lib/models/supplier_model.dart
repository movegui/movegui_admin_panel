

import 'package:movegui_admin_panel/models/model.dart';

abstract class SupplierModel extends Model {
  final String adresse, telephon, email, contact, company;

  SupplierModel({
    required super.id,
    required super.name,
    required this.adresse,
    required this.telephon,
    required this.email,
    required this.contact,
    required this.company,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'adresse': adresse,
    'telephon': telephon,
    'email': email,
    'contact': contact,
    'company': company,
  };

}

class SupplierIngredient extends SupplierModel {
  SupplierIngredient({
    required super.id,
    required super.name,
    required super.adresse,
    required super.telephon,
    required super.email,
    required super.contact,
    required super.company,
  });

  Map<String, dynamic> toJson() => super.toJson();

  factory SupplierIngredient.fromJson(Map<String, dynamic> json) =>
      SupplierIngredient(
        id: json['id'],
        name: json['name'],
        adresse: json['adresse'],
        telephon: json['telephon'],
        email: json['email'],
        contact: json['contact'],
        company: json['company'],
      );
}


