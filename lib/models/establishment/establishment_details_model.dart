import 'package:movegui_admin_panel/models/dashboard/module_item.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';

class EstablishmentDetailsModel<M extends EstablishmentModel> {

  final List<ModuleItem> staticsItems;
  final M model;
  final List<UserModel> staff;

  EstablishmentDetailsModel({required this.staticsItems, required this.model, required this.staff});

}