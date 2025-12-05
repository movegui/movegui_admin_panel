import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/patisserie_model.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/util/store_submit_hadler.dart';
import 'package:uuid/uuid.dart';

class PatisserieSubmitHandler extends StoreSubmitHadler {
  final CategoriesModel categoriesModel;
  PatisserieSubmitHandler({
    required super.service,
    required super.imageService,
    required super.collectionName,
    required this.categoriesModel
  });

  @override
  Future<void> submit({required StoreFormController form}) async {
    final imageUrl = await imageService.uploadImage(
      file: form.pickedImage,
      webBytes: form.webImage,
      collectionName: collectionName,
    );

    if (imageUrl == null) throw Exception("Image upload failed");

    final restaurant = PatisserieModel(
      id: const Uuid().v4(),
      name: form.name.text,
      description: form.description.text,
      adresse: form.adresse.text,
      telephon: form.telephon.text,
      email: form.email.text,
      contacts: form.contacts,
      weeklyHours: form.weeklyHours,
      storeType: form.selectedType!,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      category: categoriesModel,
    );

    await service.addModel(restaurant);
  }
}
