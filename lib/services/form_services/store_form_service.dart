import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/services/form_services/user_form_service.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';

abstract class StoreFormService<
  M extends StoreModel,
  FC extends StoreFormController<M>
>
    extends FormService<M, FC> {
  StoreFormService({
    required this.userFormService,
    required super.api,
    required super.seedService,
    required super.controllerFactory,
  });
  final UserFormService userFormService;
}
