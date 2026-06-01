import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class RestaurantTypeService extends ModelService<RestaurantTypeModel> {
  RestaurantTypeService({required super.api});

  @override
  Future<RestaurantTypeModel> addModel(RestaurantTypeModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
    return model;
  }

  @override
  Future<List<RestaurantTypeModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();
    return snapshot.docs
        .map((doc) => RestaurantTypeModel.fromJson(doc.data()))
        .toList();
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
  
  @override
  Future<RestaurantTypeModel> getModelById(String id) async {
       final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(id)
        .get();
    return RestaurantTypeModel.fromJson(snapshot.data()!);
  }
}
