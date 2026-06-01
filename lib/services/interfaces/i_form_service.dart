
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';

abstract class IFormService {
  Future<List<UserModel>> getContacts(List<PersonFormController> controllers);
  Future<AdressModel> getAdresse(AddressFormController controller);
}
