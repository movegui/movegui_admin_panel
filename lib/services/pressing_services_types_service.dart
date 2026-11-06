import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/types_service.dart';

class PressingServicesTypesService
    extends TypesService<PressingServiceTypeModel> {
  PressingServicesTypesService({required super.api, required super.fromJson});

  @override
  String getCollectionName() {
    return MoveGuiCollections.COLLECTION_PRESSINGS_SERVICES_TYPES;
  }

}
