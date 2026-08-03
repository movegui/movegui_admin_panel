import 'package:movegui_admin_panel/models/product_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/util/product_form_controller.dart';

abstract class ProductFormService<M extends ProductModel>
    extends FormService<M, ProductFormController<M>> {
  ProductFormService({
    required super.seedService,
    required super.controllerFactory,
    required super.api,
  });
}
