import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/establishment_category_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';


abstract class EstablishmentModel extends Model {
  final String phone, email, imageUrl;
  final AdressModel address;
  final List<OpenHoursModel> weeklyHours;
  final EstablishmentType establishmentType;
  double? rating;
  int? reviewCount;
  bool? isComplete;
  EstablishmentCategoryModel establishmentCategory;

  EstablishmentModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.isActive,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.weeklyHours,
    required this.establishmentType,
    required this.address,
    this.isComplete = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.establishmentCategory,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'email': email,
    'imageUrl': imageUrl,
    'telephon': phone,
    'weeklyHours': weeklyHours.map((weekHour) {
      return (weekHour.closeTime != null && weekHour.openTime != null)
          ? weekHour.toJson()
          : {};
    }).toList(),
    'storeType': establishmentType.toJson(),
    'address': address.toJson(),
    'rating': rating,
    'reviewCount': reviewCount,
    'isComplete': isComplete,
    'establishmentCategory': establishmentCategory.toJson()
  };
}



enum EstablishmentType {
  pressing(
    id: 'laundry',
    nameKey: 'module_pressing_name',
  ),

  other(id: '', nameKey: ''),

  restaurant(
    id: 'restaurant',
    nameKey: 'module_restaurant_name',
  );

  final String id;
  final String nameKey;

  String get collectionName {
    switch (this) {
      case EstablishmentType.pressing:
        return MoveGuiCollections.COLLECTION_PRESSINGS;
      case EstablishmentType.restaurant:
        return MoveGuiCollections.COLLECTION_RESTAURANTS;
      case EstablishmentType.other: return '';
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameKey': nameKey,
    'collectionName': collectionName
  };


  const EstablishmentType({
    required this.id,
    required this.nameKey,
  });
}

enum  EstablishmentRole {  User, Employe, Manager, Support, Driver, Owner }