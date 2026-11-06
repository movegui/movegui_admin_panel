import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/patisserie_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class PatisseriesService extends ModelService<PatisserieModel> {
  PatisseriesService({required super.api, required super.fromJson});



  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_PASTRIES;
  }

}
