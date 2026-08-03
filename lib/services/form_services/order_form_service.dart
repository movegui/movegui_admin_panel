

import 'package:movegui_admin_panel/models/order_item_model.dart';
import 'package:movegui_admin_panel/models/order_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:movegui_admin_panel/util/order_form_controller.dart';

abstract class OrderFormService<  M extends StoreModel,
  U extends UserModel,
  I extends OrderItemModel,
  OM extends OrderModel<U, I>,
  F extends FormController<M>,
  FS extends FormService<M,F> , O extends OrderFormController<M,U,I,OM,F,FS>>  extends FormService<OM, O> {
  OrderFormService({required super.api, required super.seedService, required super.controllerFactory});


}

