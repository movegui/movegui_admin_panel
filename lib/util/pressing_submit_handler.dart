import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/services/pressing_form_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/util/pressing_form_controller.dart';
import 'package:movegui_admin_panel/util/store_submit_hadler.dart';
import 'package:uuid/uuid.dart';

class PressingSubmitHandler
    extends
        StoreSubmitHadler<
          PressingModel,
          PressingService,
          PressingFormController,
          PressingFormService
        > {
  PressingSubmitHandler({
    required super.service,
    required super.imageService,
    required super.collectionName,
    required super.formService,
  });


  @override
  Future<void> submit({required PressingFormController form}) async {
    final imageUrl = await imageService.uploadImage(
      file: form.pickedImage,
      webBytes: form.webImage,
      collectionName: collectionName,
    );

    if (imageUrl == null) throw Exception("Image upload failed");
    form.contacts = await formService.getContacts(form.personForms);
    form.adressModel = await formService.getAdresse(form.addressForm);

    final pressing = PressingModel(
      id: const Uuid().v4(),
      name: form.name.text,
      description: form.description.text,
      address: form.adressModel!,
      phone: form.phone.text,
      email: form.email.text,
      contacts: form.contacts,
      weeklyHours: form.weeklyHours,
      storeType: form.selectedType,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
    );


    await service.addModel(pressing).then((p) async {
      form.services = await formService.getServices(form.serviceForms);
      await service.addServices(p, form.services).then((el) {
          form.clear();
      });
    });
  }
}
