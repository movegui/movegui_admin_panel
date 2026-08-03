import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_form_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/message_service.dart';
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
    required super.userService,
    required super.context,
  });

  @override
  Future<void> submit({required PressingFormController form}) async {
    final imageUrl = await imageService.uploadImage(
      file: form.pickedImage,
      webBytes: form.webImage,
      collectionName: collectionName,
    );

    if (imageUrl == null) throw Exception("Image upload failed");
    form.contacts = await formService.userFormService.getModels(form.userForms);
    form.adressModel = await formService.userFormService.personFormService.adressFormService.getModel(form.addressForm);

    final pressing = PressingModel(
      id: const Uuid().v4(),
      name: form.name.text,
      description: form.description.text,
      address: form.adressModel!,
      phone: form.phone.text,
      email: form.email.text,
      staff: form.contacts,
      weeklyHours: form.weeklyHours,
      storeType: form.selectedType,
      createdAt: DateTime.now(),
      imageUrl: imageUrl, 
      rating: form.rating, 
      reviewCount: form.reviewCount,
    );

    await service.addModel(pressing).then((p) async {
      form.services = await formService.servicesFormService.getModels(form.serviceForms) ;
      await service.addServices(p, form.services ?? []).then((pressing) async {
        List<HttpsCallableResult> results = [];
        for (UserModel? userModel in pressing.staff ?? [] ) {final user = FirebaseAuth.instance.currentUser;

final token = await user!.getIdTokenResult(true);

print(user.uid);
print(token.claims);

          final createUser = await userService.createUserWithoutPassword(
            userModel?.personModel?.email ?? '',
            UserRole.Manager,
            userModel?.personModel?.firstName ?? '',
            userModel?.personModel?.lastName ?? '',
            userModel?.personModel?.addresses ?? [],
            userModel?.personModel?.phone ?? '',
            userModel?.personModel?.gender ?? '',
            userModel?.personModel?.birthDate  ,
          );
          final subject = AppLocalizations.of(context)!.register_employe_title;
          final messageTitle = AppLocalizations.of(
            context,
          )!.message_movegui_title;
          final messageLink = AppLocalizations.of(
            context,
          )!.message_movegui_link;
          final message = AppLocalizations.of(context)!.message_movegui;
          final messageToSend =
              '$messageTitle \n <a href="${createUser!.resetLink}"> $messageLink </a> \n $message';
          final result = await sendMessage(
            userModel?.personModel?.firstName ?? '',
            userModel?.personModel?.lastName ?? '',
            userModel?.personModel?.email ?? '',
            userModel?.personModel?.phone ?? '',
            subject,
            messageToSend,
          );
          if (result.data['success'] == true) {
            //form.clear();
            results.add(result);
          }
        }
        if (results.length == pressing.staff?.length) {
          form.clear();
        }
      });
    });
  }
}
