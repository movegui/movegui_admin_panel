import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/store_form_service.dart';
import 'package:movegui_admin_panel/util/pressing_form_controller.dart';

class PressingFormService
    extends StoreFormService<PressingModel, PressingFormController> {
  PressingFormService({
    required super.api,
    required super.userFormService,
    required super.seedService,
    required super.controllerFactory,
    required this.servicesFormService
  });
 
 final  PressingServicesFormService servicesFormService;





  @override
  PressingModel getDefaultModel() {
    // TODO: implement getDefaultModel
    throw UnimplementedError();
  }

  @override
  Future<PressingModel> generateModel() {
    return seedService.generatePressing();
  }
  
  @override
  Future<PressingModel> getModel(PressingFormController controller) {
    // TODO: implement getModel
    throw UnimplementedError();
  }
}
