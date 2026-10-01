

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/order_item_model.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';

class OrderFromItemsController<I extends OrderItemModel>
    extends FormController<I> {
  @override
  Future<void> setData(I model) {
    return Future.value();
  }

  @override
  bool isValid(GlobalKey<FormState> formkey) {
    final currentState = formkey.currentState;
    if (currentState == null) {
      return false;
    }

    return currentState.validate();
  }
}