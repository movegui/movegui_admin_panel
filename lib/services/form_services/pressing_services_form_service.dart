import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_article_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_services_type_form_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:uuid/uuid.dart';

class PressingServicesFormService
    extends FormService<PressingServiceModel, PressingServiceFormController> {
  PressingServicesFormService({
    required super.seedService,
    required super.controllerFactory,
    required super.api,
    required this.servicesTypeFormService,
    required this.articleFormService
  });

  final PressingServicesTypeFormService servicesTypeFormService;
  final PressingArticleFormService articleFormService;


  @override
  Future<PressingServiceModel> generateModel() {
    return seedService.getGeneratedPressingService();
  }

  @override
  PressingServiceModel getDefaultModel() {
    return PressingServiceModel(
      id: Uuid().v4(),
      serviceType: PressingServiceTypeModel(
        id: Uuid().v4(),
        name: 'default',
        description: 'default',
        pricingType: PricingType.perItem,
        createdAt: DateTime.now(),
      ),
      minPrice: 0.0,
      maxPrice: 0.0,
      basePrice: 0.0,
      name: 'default',
      createdAt: DateTime.now(),
      product: PressingArticleModel(
        id: Uuid().v4(),
        name: 'default',
        createdAt: DateTime.now(),
        price: 0.0,
        supplierId: null,
        imageUrl: null,
        category: null,
        isAvailable: false,
        currency: 'GNF',
      ),
    );
  }

  @override
  Future<PressingServiceModel> getModel(
    PressingServiceFormController controller,
  ) async {
    return PressingServiceModel(
      id: controller.id ?? Uuid().v4(),
      serviceType: await servicesTypeFormService.getModel(controller.serviceTypeFormController),
      minPrice: double.parse(controller.minPrice.text),
      maxPrice: double.parse(controller.maxPrice.text),
      basePrice: controller.basePrice ?? 0.0,
      name: controller.name.text,
      createdAt: controller.createdAt ?? DateTime.now(),
      product: await articleFormService.getModel(controller.articleFormController),
    );
  }
}
