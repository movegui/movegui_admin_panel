// ignore_for_file: non_constant_identifier_names

import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:uuid/uuid.dart';

class AdressModel extends Model {
  final GeoCordinatesModel? geoCordinates;
  final String address;
  final String? district;
  final String minucipality;
  final AdressType adressType;
  final String? zipCode;
  final String? ville;
  final String? pays;
  final int? houseNumber;
  final int? appartementNumber;
  final int? floor;
  bool isDefault;
  AdressModel({
    this.geoCordinates,
    required this.address,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.district,
    required this.minucipality,
    required this.adressType,
    this.zipCode = '00000',
    this.ville = 'Conakry',
    this.pays = 'Guinee',
    this.isDefault = false,
    this.appartementNumber = 0,
    this.floor = 0,
    this.houseNumber = 0,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'geoCordinates': geoCordinates?.toJson(),
    'address': address,
    'district': district,
    'minucipality': minucipality,
    'adressType': adressType.name,
    'zipCode': zipCode,
    'ville': ville,
    'pays': pays,
    'isDefault': isDefault,
    'appartementNumber': appartementNumber,
    'floor': floor,
    'houseNumber': houseNumber,
  };

  factory AdressModel.fromJson(Map<String, dynamic> json) => AdressModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
    geoCordinates: json['geoCordinates'] != null
        ? GeoCordinatesModel.fromJson(json['geoCordinates'])
        : null,
    address: json['address'] ?? '',
    district: json['district'] ?? '',
    minucipality: json['minucipality'] ?? 'di',
    adressType: AdressType.values.firstWhere(
      (adressType) => adressType.name == json['adressType'],
      orElse: () => AdressType.other,
    ),
    zipCode: json['zipCode'] ?? '',
    ville: json['ville'] ?? '',
    pays: json['pays'] ?? '',
    isDefault: json['isDefault'] ?? false,
    appartementNumber: json['appartementNumber'] ?? 0,
    floor: json['floor'] ?? 0,
    houseNumber: json['houseNumber'] ?? 0,
  );

  String getMapAddress() {
    return '$address , $district, $minucipality, $ville, $pays';
  }

  static AdressModel getDaulftObject() => AdressModel(
    address: '',
    id: Uuid().v4(),
    name: '',
    createdAt: DateTime.now(),
    district: '',
    minucipality: 'di',
    geoCordinates: GeoCordinatesModel(longitude: 0.0, latitude: 0.0),
    adressType: AdressType.home,
    isDefault: false,
    appartementNumber: 0,
    floor: 0,
    houseNumber: 0,
  );

  static getCollectionName() {
    return 'adresses';
  }

  String get zoneId => '${adressType.name}_${minucipality}_$district';
}

class _AdressType {
  static const String HOME = 'h';
  static const String OFFICE = 'o';
  static const String NEIGHBOR = 'n';
  static const String OTHER = 'ot';
}

enum AdressType {
  home(_AdressType.HOME),
  office(_AdressType.OFFICE),
  neighbor(_AdressType.NEIGHBOR),
  other(_AdressType.OTHER);

  final String id;
  const AdressType(this.id);
}
