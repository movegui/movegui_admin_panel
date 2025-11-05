import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class RestaurantTypeService extends ModelService<RestaurantTypeModel>{


  @override
  Future<void> addModel(RestaurantTypeModel model) async {
      await FirebaseFirestore.instance.collection(getCollectionName()).doc(model.id).set(model.toJson());
  }

  @override
  Future<List<RestaurantTypeModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance.collection(getCollectionName()).get();
    return snapshot.docs.map((doc) => RestaurantTypeModel.fromJson(doc.data())).toList();

  }

  @override
  String getCollectionName() {
    return "restaurant_type_model";
  }

  
    @override
  Future<List<RestaurantTypeModel>> getByName(String name) async {
      final snapshot = await FirebaseFirestore.instance
      .collection(getCollectionName())
      .where('name', isEqualTo: name) 
      .get();

  return snapshot.docs
      .map((doc) => RestaurantTypeModel.fromJson(doc.data()))
      .toList();
  }
}