import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class RestaurantsService extends ModelService<RestaurantModel> {
  RestaurantsService({required super.api, required super.fromJson});



  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_RESTAURANTS;
  }

}
