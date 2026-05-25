import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/services/form_service.dart';
import 'package:movegui_admin_panel/util/pressing_service_form_controller.dart';
import 'package:uuid/uuid.dart';

class PressingFormService extends FormService<PressingModel> {
  PressingFormService({required super.api});

  Future<List<PressingServiceModel>> getServices(
    List<PressingServiceFormController> formControllers,
  ) async {
    print('service type: ${formControllers[0].estimatedDuration.toString()}');
    return Future.wait(
      formControllers.map((controller) async {
        return PressingServiceModel(
          article: PressingArticleModel(
            id: Uuid().v4(),
            name: controller.name.text.trim(),
            iconUrl: null,
            createdAt: DateTime.now(),
          ),
          serviceType: controller.serviceType!,
          minPrice: controller.minPrice.text.trim().isEmpty
              ? null
              : double.parse(controller.minPrice.text.trim()),
          maxPrice: controller.maxPrice.text.trim().isEmpty
              ? null
              : double.parse(controller.maxPrice.text.trim()),
          basePrice: controller.minPrice.text.trim().isEmpty
              ? controller.maxPrice.text.trim().isEmpty
                    ? null
                    : double.parse(controller.maxPrice.text.trim())
              : double.parse(controller.minPrice.text.trim()),
          id: Uuid().v4(),
          estimatedDuration: controller.estimatedDuration ,
          name: '${controller.name.text.trim()} ${controller.serviceType!.name}',
          createdAt: DateTime.now(),
        );
      }).toList(),
    );
  }
}
