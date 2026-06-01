import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/model.dart';

class AdressModel extends Model {
  final GeoCordinatesModel? geoCordinates;
  final String? zoneId;
  final String address;
  final String? district;
  final String? minucipality;
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
    required this.district,
    required this.minucipality,
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
    'district': district,
    'minucipality': minucipality,
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
    address: json['address'] ?? '',
    district: json['district'] ?? '',
    minucipality: json['minucipality'] ?? '',
    zipCode: json['zipCode'] ?? '',
    ville: json['ville'] ?? '',
    pays: json['pays'] ?? '',
  );

  String getMapAddress(){
    return '$address , $district, $minucipality, $ville, $pays';
  }
}
