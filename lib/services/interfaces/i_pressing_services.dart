


import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';

abstract class IPressingServices  {
  Future<List<PressingServiceModel>> getAllServices(String id);
    Future<PressingModel> addServices(
    PressingModel pressing,
    List<PressingServiceModel>? services,
  );
    Future<void> deleteServices(
    PressingModel pressing,
    List<PressingServiceModel>? services,
  );
 }