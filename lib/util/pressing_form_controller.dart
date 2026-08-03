import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';

class PressingFormController extends StoreFormController<PressingModel> {
   List<PressingServiceFormController> serviceForms = [PressingServiceFormController()];
  List<PressingServiceModel>? services = [];

  @override
  Future<void> setData(PressingModel model) async {

    await super.setData(model);
    serviceForms.asMap().entries.map((entry) async {
       final index = entry.key;
       final serviceForm = entry.value;
     await  serviceForm.setData(services![index] );
    }).toList();
  }

  @override
  void clear() {
    super.clear();
    for(final serviceForm in serviceForms){
      serviceForm.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
        for(final serviceForm in serviceForms){
      serviceForm.dispose();
    }
  }
}
