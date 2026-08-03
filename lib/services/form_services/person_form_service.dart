import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/services/form_services/adress_form_service.dart';
import 'package:movegui_admin_panel/services/form_services/form_service.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:uuid/uuid.dart';

class PersonFormService extends FormService<PersonModel, PersonFormController> {
  PersonFormService({
    required this.adressFormService,
    required super.api,
    required super.controllerFactory,
    required super.seedService,
  });
  final AdressFormService adressFormService;

  @override
  Future<PersonModel> getModel(PersonFormController controller) async {
    return PersonModel(
      id: const Uuid().v4(),
      firstName: controller.firstName.text.trim(),
      lastName: controller.lastName.text.trim(),
      name:
          "${controller.firstName.text.trim()} ${controller.lastName.text.trim()}",
      createdAt: DateTime.now(),
      middleName: controller.middleName.text.isEmpty
          ? null
          : controller.middleName.text.trim(),
      profileImageUrl: await uploadImageToFirebase(
        controller.webImage!,
        controller.pickedImage,
      ),
      birthDate: controller.birthdate,
      addresses: [
        AdressModel(
          address: controller.addressesForms[0].address.text.trim(),
          id: Uuid().v4(),
          name: controller.addressesForms[0].selectedType,
          createdAt: DateTime.now(),
          district: controller.addressesForms[0].district.text.trim(),
          minucipality: controller.addressesForms[0].selectedMunicipality,
          zoneId:
              '${controller.addressesForms[0].selectedMunicipality}_${controller.addressesForms[0].district.text.trim()}_${controller.addressesForms[0].address.text.trim()}',
          geoCordinates: GeoCordinatesModel(
            longitude: double.parse(
              controller.addressesForms[0].longitude.text.trim(),
            ),
            latitude: double.parse(
              controller.addressesForms[0].latitude.text.trim(),
            ),
          ),
          adressType: '',
        ),
      ],
      email: controller.email.text.trim(),
      phone: controller.phone.text.trim(),
      gender: controller.gender!,
      //  image: images[i],
    );
  }

  @override
  PersonModel getDefaultModel() {
    return PersonModel(
      id: Uuid().v4(),
      name: 'default',
      createdAt: DateTime.now(),
      firstName: 'default',
      lastName: 'default',
      profileImageUrl: 'default',
      email: 'default@default.com',
      phone: '000000000000000',
      gender: 'm',
      birthDate: DateTime.now(),
      addresses: [adressFormService.getDefaultModel()],
    );
  }

  @override
  Future<PersonModel> generateModel() {
    return seedService.getGeneratedPerson();
  }
}
