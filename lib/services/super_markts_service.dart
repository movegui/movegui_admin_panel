import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/super_markt_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class SuperMarktsService extends ModelService<SuperMarktModel> {
  SuperMarktsService({required super.api, required super.fromJson});


  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_SUPER_MARKETS;
  }

}
