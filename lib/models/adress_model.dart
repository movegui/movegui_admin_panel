import 'package:movegui_admin_panel/models/model.dart';

class AdressModel extends Model {
  final double? longitude;
  final double? latitude;
  final String? zoneId;
  final String address;
  final String? quartier;
  final String? commune;
  final int? zipCode;
  final String? ville;
  final String? pays;
  AdressModel({
    this.longitude,
    this.latitude,
    this.zoneId,
    required this.address,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.quartier,
    required this.commune,
    this.zipCode = 00000,
    this.ville = 'Conakry',
    this.pays = 'Guinee',
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'longitude': longitude,
    'latitude': latitude,
    'zoneId': zoneId,
    'address': address,
    'quartier': quartier,
    'commune': commune,
    'zipCode': zipCode,
    'ville': ville,
    'pays': pays,
  };

  factory AdressModel.fromJson(Map<String, dynamic> json) => AdressModel(
    id: json['id'],
    name: json['name'],
    createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
    longitude: json['longitude'],
    latitude: json['latitude'],
    address: json['adress'],
    quartier: json['quartier'],
    commune: json['commune'],
    zipCode: json['zipCode'],
    ville: json['ville'],
    pays: json['pays'],
  );
}
