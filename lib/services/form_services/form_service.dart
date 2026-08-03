import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:movegui_admin_panel/config/env_dev.dart';
import 'package:movegui_admin_panel/models/model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_form_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/seed_service.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';

abstract class FormService<M extends Model, F extends FormController<M>>
    implements IFormService<M, F> {
  final ApiService api;
  final F Function() controllerFactory;
  final SeedService seedService;

  FormService({required this.seedService, required this.controllerFactory, required this.api});

  Future<String?> uploadImageToFirebase(
    Uint8List? webImage,
    File? pickedImage,
  ) async {
    try {
      final storage = FirebaseStorage.instance;

      // Create a unique file name
      String fileName = 'persons/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = storage.ref().child(fileName);

      UploadTask uploadTask;

      if (kIsWeb) {
        // Upload bytes for web
        UploadTask uploadTask = ref.putData(
          webImage!, // from your _pickImage()
          SettableMetadata(contentType: 'image/jpeg'),
        );
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        // Upload file for mobile
        UploadTask uploadTask = ref.putFile(
          pickedImage!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      throw Exception(e.toString());
      // return null;
    }
  }

  @override
  Future<F> getFormController(M? model) async {
    final form = controllerFactory();
    form.setData(model ?? getDefaultModel());
    return form;
  }

  @override
  Future<List<F>> getFormControllers(List<M>? models) async {
    List<F> forms = [];
    int size = models?.length ?? 0;
    if (size > 0) {
      for (int i = 0; i < size; i++) {
        final form = await getFormController(models?[i]);
        forms.add(form);
      }
    } else {
      final seedService = getIt<SeedService>();
      if (seedService.api.env is EnvDev) {
        final testData = await generateModel();

        forms.add(controllerFactory());
        forms[0].setData(testData);
      } else {
        forms.add(controllerFactory());
      }
    }
    return forms;
  }

    @override
  Future<List<M>> getModels(List<F> controllers) async {
     return Future.wait(
      controllers.map((controller) async {
        return  await getModel(controller);
      }).toList(),
    );
  }
}
