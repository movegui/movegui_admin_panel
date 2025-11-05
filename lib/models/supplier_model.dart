

import 'package:movegui_admin_panel/models/model.dart';

  class SupplierModel extends Model {
  final String adresse, telephon, email, contact, company, type;

  SupplierModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.adresse,
    required this.telephon,
    required this.email,
    required this.contact,
    required this.company,
    required this.type
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'adresse': adresse,
    'telephon': telephon,
    'email': email,
    'contact': contact,
    'company': company,
    'type': type
  };

    factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      SupplierModel(
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

}


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




