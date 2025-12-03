import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';

abstract class StoreModel extends Model {

  final String adresse, telephon, email, imageUrl, description;
  final double? longitude;
  final double? latitude;
  final List<PersonModel> contacts;
  final List<OpenHours> weeklyHours;

  StoreModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.description,
    required this.adresse,
    required this.email,
    required this.imageUrl,
    required this.telephon,
    required this.contacts,
    required this.weeklyHours,
    this.longitude,
    this.latitude,

  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'adresse': adresse,
    'contacts': contacts.map((contact) {
      return contact.toJson();
    }).toList(),
    'email': email,
    'imageUrl': imageUrl,
    'telephon': telephon,
    'longitude': longitude,
    'latitude': latitude,
    'weeklyHours': weeklyHours.map((weekHour){
       return weekHour.toJson();
    }).toList()
    
  };


/*
      factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel (
      id: json['id'],
      name: json['name'],
      description: json['description'],
      adresse: json['adresse'],
      contact: json['contact'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      telephon: json['telephon'],
    );
    */

}
