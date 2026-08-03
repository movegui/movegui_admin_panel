import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

abstract class StoreModelOld extends Model {

  final String  phone, email, imageUrl, description;
  final AdressModel address; 
  final List<UserModel> staff;
  final List<OpenHoursModel> weeklyHours;
  final StoreTypeModel? storeType;
  double rating ;
  int reviewCount;

  StoreModelOld({
    required super.id,
    required super.name,
    required super.createdAt,
    required this.description,
    required this.email,
    required this.imageUrl,
    required this.phone,
    required this.staff,
    required this.weeklyHours,
    required this.storeType,
    required this.address,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  @override
  Map<String, dynamic> toJson() => {
    
    ...super.toJson(),
    'description': description,
    'staff': staff.map((user) {
      return user.toJson();
    }).toList(),
    'email': email,
    'imageUrl': imageUrl,
    'telephon': phone,
    'weeklyHours': weeklyHours.map((weekHour){
      return (weekHour.closeTime != null && weekHour.openTime != null) ?
         weekHour.toJson() : {};
    }).toList(),
    'storeType': storeType?.toJson(),
    'address': address.toJson(), 
    'rating': rating,
    'reviewCount': reviewCount,
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


 abstract class StoreTypeModelOld extends Model {
  StoreTypeModelOld({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt,
  };

/*
  factory StoreTypeModel.fromJson(Map<String, dynamic> json) =>
      StoreTypeModel(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'] != null
            ? json['createdAt'].toDate()
            : DateTime.now(),
      );
      */
        
      
     

  @override
  String toString() {
    // TODO: implement toString
    return  'RestaurantModel(id: $id, name: $name, createdAt: $createdAt)';
  }

}

