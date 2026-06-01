import 'package:flutter/widgets.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/services/form_service.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:movegui_admin_panel/services/user_service.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';

abstract class StoreSubmitHadler<
  M extends Model,
  T extends ModelService<M>,
  S extends StoreFormController,
  F extends FormService
> {
  final T service;
  final ImageService imageService;
  final String collectionName;
  final F formService;
  final UserService userService;
  final BuildContext context;

  StoreSubmitHadler({
    required this.service,
    required this.imageService,
    required this.collectionName,
    required this.formService,
    required this.userService,
    required this.context,
  });

  Future<void> submit({required S form});
}
