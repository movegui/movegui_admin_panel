import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_type_form_controller.dart';
import 'package:uuid/uuid.dart';

class PressingServicesTypeFormService
    extends
        FormService<
          PressingServiceTypeModel,
          PressingServiceTypeFormController
        > {
  PressingServicesTypeFormService({
    required super.seedService,
    required super.controllerFactory,
    required super.api,
  });

  @override
  Future<PressingServiceTypeModel> generateModel() {
    return seedService.generatePressingTypeModel();
  }

  @override
  PressingServiceTypeModel getDefaultModel() {
    return PressingServiceTypeModel(
      id: Uuid().v4(),
      name: 'default',
      description: 'default',
      pricingType: PricingType.fixed,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<PressingServiceTypeModel> getModel(
    PressingServiceTypeFormController controller,
  ) async {
    return PressingServiceTypeModel(
      id: controller.id ?? '',
      name: controller.name.text,
      description: controller.description.text,
      pricingType: controller.pricingType ?? PricingType.fixed,
      createdAt: controller.createdAt ?? DateTime.now(),
    );
  }
}
