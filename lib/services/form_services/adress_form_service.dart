import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:uuid/uuid.dart';

class AdressFormService  extends FormService<AdressModel,AddressFormController> {
  AdressFormService({required super.api, required super.seedService, required super.controllerFactory});

  @override
  Future<AdressModel> getModel(AddressFormController controller) async {
    return AdressModel(
    address: controller.address.text,
    id: controller.id ?? Uuid().v4(),
    name: '${controller.address.text}_${controller.district.text}_${controller.selectedMunicipality}',
    createdAt: controller.createdAt ?? DateTime.now(),
    district: controller.district.text,
    minucipality: controller.selectedMunicipality,
    geoCordinates: GeoCordinatesModel(
      longitude: controller.longitude.text.isNotEmpty ?  double.parse(controller.longitude.text) : null,
      latitude: controller.latitude.text.isNotEmpty ?  double.parse(controller.latitude.text) :null,
    ),
    adressType: controller.selectedType,
    isDefault: controller.isDefault
  );
  
  }
 

      String getAdressType(String value, BuildContext context) {
    switch (value) {
      case 'h':
        return AppLocalizations.of(context)!.address_home_title;
      case 'o':
        return AppLocalizations.of(context)!.address_office_title;
      case 'n':
        return AppLocalizations.of(context)!.address_neighbor_title;
      case 'ot':
        return AppLocalizations.of(context)!.address_other_title;
      default:
        return 'No Type';
    }
  }
  
  @override
  AdressModel getDefaultModel() {
   return AdressModel(
    address: 'default',
    id: Uuid().v4(),
    name: 'default',
    createdAt: DateTime.now(),
    district: 'default',
    minucipality: 'di',
    geoCordinates: GeoCordinatesModel(longitude: 0.0, latitude: 0.0),
    adressType: 'h',
    isDefault: false,
  );
  }
  
  @override
  Future<AdressModel> generateModel() async {
    return await  seedService.getgeneratedAdress();
  }
}