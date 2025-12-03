import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/professionnel_model.dart';
import 'package:uuid/uuid.dart';

class PersonModel extends Model {
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? profileImageUrl;
  final String email;
  final String phone;
  final String gender;
  final DateTime? birthDate;
  final String address;
  final String? nationality;

  PersonModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.profileImageUrl,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthDate,
    required this.address,
    this.nationality
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'firstName': firstName,
    'lastName': lastName,
    'middleName': middleName,
    'profileImageUrl': profileImageUrl,
    'email': email,
    'phone': phone,
    'gender': gender,
    'birthDate': birthDate!.toIso8601String(),
    'address': address,
    'nationality': nationality,

  };

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json['id'],
    name: json['name'],
    createdAt: json['createdAt'].toDate(),
    firstName: json['firstName'],
    lastName: json['lastName'],
    middleName: json['middleName'],
    profileImageUrl: json['profileImageUrl'],
    email: json['email'],
    phone: json['phone'],
    gender: json['gender'],
    birthDate: json['birthDate'] != null
    ? DateTime.parse(json['birthDate'])
    : null,
    address: json['address'],
    nationality: json['nationality']
  );


  factory PersonModel.empty() => PersonModel(
    id: Uuid().v4(),
    name: '',
    createdAt: DateTime.now(),
    firstName: '',
    lastName: '',
    middleName: '',
    profileImageUrl: '',
    email: '',
    phone: '',
    gender: '',
    birthDate: DateTime(1800, 1, 1),
    address: '',
    nationality: ''
  );

  @override
  String toString() {
    
    return super.toString() + firstName + ' ' + lastName + ' '+ email + ' ' + phone;
  }
}
