import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/model.dart';

class AdressModel extends Model {
  final GeoCordinatesModel? geoCordinates;
  final String? zoneId;
  final String address;
  final String? quartier;
  final String? commune;
  final int? zipCode;
  final String? ville;
  final String? pays;
  AdressModel({
    this.geoCordinates,
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
    'geoCordinates': geoCordinates?.toJson(),
    'zoneId': zoneId,
    'address': address,
    'quartier': quartier,
    'commune': commune,
    'zipCode': zipCode,
    'ville': ville,
    'pays': pays,
  };

  factory AdressModel.fromJson(Map<String, dynamic> json) => AdressModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
    geoCordinates: json['geoCordinates'] != null ? GeoCordinatesModel.fromJson(json['geoCordinates']) : null,
    address: json['adress'] ?? '',
    quartier: json['quartier'] ?? '',
    commune: json['commune'] ?? '',
    zipCode: json['zipCode'] ?? '',
    ville: json['ville'] ?? '',
    pays: json['pays'] ?? '',
  );

  String getMapAddress(){
    return '$address , $quartier, $commune, $ville, $pays';
  }
}
