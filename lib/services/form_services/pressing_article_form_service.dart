import 'package:movegui_admin_panel/models/pressing/pressing_article_model.dart';
import 'package:movegui_admin_panel/services/form_services/product_form_service.dart';
import 'package:movegui_admin_panel/util/product_form_controller.dart';
import 'package:uuid/uuid.dart';

class PressingArticleFormService
    extends ProductFormService<PressingArticleModel> {

  PressingArticleFormService({
    required super.seedService,
    required super.controllerFactory,
    required super.api,
  });

  @override
  Future<PressingArticleModel> generateModel() async {
    return seedService.generatePressingArticle();
  }

  @override
  PressingArticleModel getDefaultModel() {
   return PressingArticleModel(
          id: Uuid().v4(),
          name: 'default',
          createdAt: DateTime.now(),
          price: null,
          supplierId: Uuid().v4(),
          imageUrl: 'assets',
          category:   'assets/images/categories/default_image.png',
          isAvailable: true,
          currency: 'GNF',
        );
  }

  @override
  Future<PressingArticleModel> getModel(
    ProductFormController<PressingArticleModel> controller,
  ) async {
      return PressingArticleModel(
          id: Uuid().v4(),
          name: controller.name.text,
          createdAt: DateTime.now(),
          price: null,
          supplierId: Uuid().v4(),
          imageUrl: 'assets/images/categories/default_image.png',
          category:   '',
          isAvailable: true,
          currency: 'GNF',
        );
  }
}
