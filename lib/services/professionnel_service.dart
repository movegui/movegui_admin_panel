
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/professionnel_model.dart';
import 'package:movegui_admin_panel/services/model_service.dart';

class ProfessionnelService extends ModelService<ProfessionnelModel> {
  ProfessionnelService({required super.api, required super.fromJson});

  

  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_PROFESSIONNELS;
  }

}
