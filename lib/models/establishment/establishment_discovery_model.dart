import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';

class EstablishmentDiscoveryModel extends Model {
  final EstablishmentType establishmentType;
  final AdressModel address;
  final String? imageUrl;
  final double rating;
  final List<OpenHoursModel> weeklyHours;
  final String establishmentId;

  EstablishmentDiscoveryModel({
    required super.id,
    required this.establishmentId,
    required this.establishmentType,
    required super.name,
    required this.address,
    required this.rating,
    required super.isActive,
    required super.createdAt,
    required this.weeklyHours,
    this.imageUrl,
    super.description,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'imageUrl': imageUrl,
    'establishmentType': establishmentType.toJson(),
    'address': address.toJson(),
    'rating': rating,
    'weeklyHours': weeklyHours.map((hour) => hour.toJson()).toList(),
    'establishmentId': establishmentId,
  };

  factory EstablishmentDiscoveryModel.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'];
    if (addressJson is! Map) {
      throw FormatException(
        'Missing or invalid "address" map in pressing "${json['id']}".',
      );
    }

    final rawStoreType = json['establishmentType'];
    final String normalizedStoreTypeId = rawStoreType is Map
        ? (rawStoreType['id'] as String? ??
              rawStoreType['name'] as String? ??
              'other')
        : (rawStoreType is String ? rawStoreType : 'other');

    return EstablishmentDiscoveryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? '',
      address: AdressModel.fromJson(Map<String, dynamic>.from(addressJson)),
      createdAt: json['createdAt'] != null
          ? json['createdAt'].toDate()
          : DateTime.now(),
      establishmentType: EstablishmentType.values.firstWhere(
        (store) =>
            store.id == normalizedStoreTypeId ||
            store.name == normalizedStoreTypeId,
        orElse: () => EstablishmentType.other,
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] is bool ? json['isActive'] as bool : false,
      weeklyHours: (json['weeklyHours'] as List? ?? [])
          .map((e) => OpenHoursModel.fromJson(e))
          .toList(),
      establishmentId: json['establishmentId'],
    );
  }
}


/*

// ignore_for_file: non_constant_identifier_names

import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:uuid/uuid.dart';
class AdressModel extends Model {
  final GeoCordinatesModel? geoCordinates;
  final String? zoneId;
  final String address;
  final String? district;
  final String minucipality;
  final String adressType;
  final int? zipCode;
  final String? ville;
  final String? pays;
  bool isDefault;
  AdressModel({
    this.geoCordinates,
    this.zoneId,
    required this.address,
    required super.id,
    required super.name,
    required super.createdAt,
    required this.district,
    required this.minucipality,
    required this.adressType,
    this.zipCode = 00000,
    this.ville = 'Conakry',
    this.pays = 'Guinee',
    this.isDefault = false,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'geoCordinates': geoCordinates?.toJson(),
    'zoneId': zoneId,
    'address': address,
    'district': district,
    'minucipality': minucipality,
    'adressType': adressType,
    'zipCode': zipCode,
    'ville': ville,
    'pays': pays,
    'isDefault': isDefault,
  };

  factory AdressModel.fromJson(Map<String, dynamic> json) => AdressModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    createdAt:
        json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now(),
    geoCordinates:
        json['geoCordinates'] != null
            ? GeoCordinatesModel.fromJson(json['geoCordinates'])
            : null,
    address: json['address'] ?? '',
    district: json['district'] ?? '',
    minucipality: json['minucipality'] ?? 'di',
    adressType: json['adressType'] ?? 'h',
    zipCode: json['zipCode'] ?? '',
    ville: json['ville'] ?? '',
    pays: json['pays'] ?? '',
    isDefault: json['isDefault'] ?? false,
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
    adressType: 'h',
    isDefault: false,
  );
  

  static getCollectionName() {
    return 'adresses';
  }


}

class AddressType {
  static String HOME = 'h';
  static String OFFICE = 'o';
  static String NEIGHBOR = 'n';
  static String OTHER = 'ot';
}



 */