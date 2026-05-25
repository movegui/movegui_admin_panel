import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class RestaurantsService extends ModelService<RestaurantModel> {
  RestaurantsService({required super.api});

  @override
  Future<RestaurantModel> addModel(RestaurantModel model) async {
    await FirebaseFirestore.instance
        .collection(getCollectionName())
        .doc(model.id)
        .set(model.toJson());
    return model;
  }

  @override
  Future<List<RestaurantModel>> allModels() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .get();
    return snapshot.docs
        .map((doc) => RestaurantModel.fromJson(doc.data()))
        .toList();
  }

  @override
  String getCollectionName() {
    return "restaurants_model";
  }

  @override
  Future<List<RestaurantModel>> getByName(String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(getCollectionName())
        .where('name', isEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => RestaurantModel.fromJson(doc.data()))
        .toList();
  }
}
