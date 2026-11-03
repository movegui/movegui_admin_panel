import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

abstract class StoreModel extends Model {
  final String phone, email, imageUrl;
  final AdressModel address;
  final List<UserModel>? staff;
  final List<OpenHoursModel> weeklyHours;
  final StoreType storeType;
  double? rating;
  int? reviewCount;
  bool? isComplete;

  StoreModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.description,
    required super.isActive,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.staff,
    required this.weeklyHours,
    required this.storeType,
    required this.address,
    this.isComplete = false,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'description': description,
    'staff': staff != null && staff!.isNotEmpty
        ? staff!.map((user) {
            return user.toJson();
          }).toList()
        : [],
    'email': email,
    'imageUrl': imageUrl,
    'telephon': phone,
    'weeklyHours': weeklyHours.map((weekHour) {
      return (weekHour.closeTime != null && weekHour.openTime != null)
          ? weekHour.toJson()
          : {};
    }).toList(),
    'storeType': storeType.type.toJson(),
    'address': address.toJson(),
    'rating': rating,
    'reviewCount': reviewCount,
    'isComplete': isComplete,
  };
}

 class _StoreTypeModel extends Model {
  _StoreTypeModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {...super.toJson()};

  factory _StoreTypeModel.fromJson(Map<String, dynamic> json) => _StoreTypeModel(
    id: json['id'],
    name: json['name'],
    createdAt: json['createdAt'] != null
        ? json['createdAt'].toDate()
        : DateTime.now(),
  );

  String getStoreTypeNameKey() {
    switch (id) {
      case 'restaurant':
        return 'module_restaurant_name';
      case 'cafe':
        return 'module_cafe_name';
      case 'grocery':
        return 'module_grocery_name';
      case 'pharmacy':
        return 'module_pharmacy_name';
      case 'laundry':
        return 'module_pressing_name';
      default:
        return 'module_other_name';
    }
  }
}

enum StoreType {
  restaurant(id: 'restaurant', name: 'Restaurant'),
  cafe(id: 'cafe', name: 'Cafe'),
  grocery(id: 'grocery', name: 'Grocery'),
  pharmacy(id: 'pharmacy', name: 'Pharmacy'),
  laundry(id: 'laundry', name: 'Laundry'),
  other(id: 'other', name: 'Other');

  final String id;
  final String name;

  const StoreType({required this.id, required this.name});

  _StoreTypeModel get type =>
      _StoreTypeModel(id: id, name: name, createdAt: DateTime.now());

}
