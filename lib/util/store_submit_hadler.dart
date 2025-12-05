import 'package:movegui_admin_panel/models/store_model.dart';
import 'package:movegui_admin_panel/services/image_service.dart';
import 'package:movegui_admin_panel/services/model_service.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';

abstract class StoreSubmitHadler {

    final ModelService service;
    final ImageService imageService;
    final String collectionName;

  StoreSubmitHadler({
    required this.service,
    required this.imageService,
    required this.collectionName
  });

   Future<void> submit({
    required StoreFormController form,
  });
}

