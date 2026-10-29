import 'dart:developer';

import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_model.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';
import 'package:movegui_admin_panel/services/form_services/pressing_form_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/services/message_service.dart';
import 'package:movegui_admin_panel/services/pressing_service.dart';
import 'package:movegui_admin_panel/services/pressing_services_types_service.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
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
    final imageUrl =
        (form.imageUrl != null &&
            form.imageUrl!.isNotEmpty &&
            form.webImage == null &&
            form.pickedImage == null)
        ? form.imageUrl
        : await imageService.uploadImage(
            file: form.pickedImage,
            webBytes: form.webImage,
            collectionName: collectionName,
          );

    if (imageUrl == null) throw Exception("Image upload failed");
    form.adressModel = await formService
        .userFormService
        .personFormService
        .adressFormService
        .getModel(form.addressForm);

    final pressing = PressingModel(
      id: form.id ?? Uuid().v4(),
      name: form.name.text,
      description: form.description.text,
      address: form.adressModel!,
      phone: form.phone.text,
      email: form.email.text,
      staff: form.staff,
      weeklyHours: form.weeklyHours,
      storeType: form.selectedType,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      rating: form.rating,
      reviewCount: form.reviewCount,
      isActive: form.isActive,
      isComplete: form.isCompleted,
    );

    final previousServices = form.editMode && form.id != null
        ? await service.getAllServices(form.id!)
        : <PressingServiceModel>[];
    final currentServices = form.services ?? [];
    final savedPressing = await service.addModel(pressing);
    final currentServicesById = {
      for (final pressingService in currentServices) pressingService.id,
    };
    final removedServices = previousServices
        .where((pressingService) => !currentServicesById.contains(pressingService.id))
        .toList();
    if (removedServices.isNotEmpty) {
      await service.deleteServices(savedPressing, removedServices);
    }
    final pressingWithServices = await service.addServices(
      savedPressing,
      currentServices,
    );

    final previousCounts = _countServicesByTypeId(previousServices);
    final currentCounts = _countServicesByTypeId(currentServices);
    final affectedTypeIds = {...previousCounts.keys, ...currentCounts.keys};
    final typesById = <String, PressingServiceTypeModel>{
      for (final pressingService in previousServices)
        pressingService.serviceType.id: pressingService.serviceType,
      for (final pressingService in currentServices)
        pressingService.serviceType.id: pressingService.serviceType,
    };
    final pressingServiceTypeService = getIt<PressingServicesTypesService>();
    for (final savedType in await pressingServiceTypeService.allModels()) {
      if (affectedTypeIds.contains(savedType.id)) {
        typesById[savedType.id] = savedType;
      }
    }

    for (final typeId in affectedTypeIds) {
      final type = typesById[typeId]!;
      final countDelta =
          (currentCounts[typeId] ?? 0) - (previousCounts[typeId] ?? 0);
      final updatedCount = (type.servicesCount ?? 0) + countDelta;
      type.servicesCount = updatedCount < 0 ? 0 : updatedCount;
      await pressingServiceTypeService.addModel(type);
    }

    final staff = pressingWithServices.staff ?? [];
    var successfulMessages = 0;
    var savedStaff = 0;

    for (final userModel in staff) {
      if (!form.editMode) {
        final createUser = await userService.createUserWithoutPassword(
          userModel.personModel?.email ?? '',
          userModel.role ?? UserRole.Guest,
          userModel.personModel?.firstName ?? '',
          userModel.personModel?.lastName ?? '',
          userModel.personModel?.addresses ?? [],
          userModel.personModel?.phone ?? '',
          userModel.personModel?.gender ?? '',
          userModel.personModel?.birthDate,
        );
        if (createUser == null) {
          throw StateError(
            'Failed to create account for ${userModel.personModel?.email ?? 'staff member'}',
          );
        }

        final localizations = AppLocalizations.of(context)!;
        final messageToSend =
            '${localizations.message_movegui_title} \n '
            '<a href="${createUser.resetLink}"> '
            '${localizations.message_movegui_link} </a> \n '
            '${localizations.message_movegui}';
        final result = await sendMessage(
          userModel.personModel?.firstName ?? '',
          userModel.personModel?.lastName ?? '',
          userModel.personModel?.email ?? '',
          userModel.personModel?.phone ?? '',
          localizations.register_employe_title,
          messageToSend,
        );
        if (result.data['success'] == true) {
          successfulMessages++;
        }
      } else {
        await userService.addModel(userModel);
        savedStaff++;
      }
    }

    final allStaffProcessed = form.editMode
        ? savedStaff == staff.length
        : successfulMessages == staff.length;
    if (allStaffProcessed) form.clear();
  }

  Map<String, int> _countServicesByTypeId(
    Iterable<PressingServiceModel> services,
  ) {
    final counts = <String, int>{};
    for (final pressingService in services) {
      counts.update(
        pressingService.serviceType.id,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    return counts;
  }
}
