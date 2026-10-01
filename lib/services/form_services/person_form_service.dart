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
    final uploadedImageUrl = await uploadImageToFirebase(
      controller.webImage,
      controller.pickedImage,
    );

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
      profileImageUrl: uploadedImageUrl ?? controller.profileImageUrl,
      birthDate: controller.birthDate,
      addresses: [
        AdressModel(
          address: controller.adressesForms[0].address.text.trim(),
          id: Uuid().v4(),
          name: controller.adressesForms[0].selectedType,
          createdAt: DateTime.now(),
          district: controller.adressesForms[0].district.text.trim(),
          minucipality: controller.adressesForms[0].selectedMunicipality,
          zoneId:
              '${controller.adressesForms[0].selectedMunicipality}_${controller.adressesForms[0].district.text.trim()}_${controller.adressesForms[0].address.text.trim()}',
          geoCordinates: GeoCordinatesModel(
            longitude: double.parse(
              controller.adressesForms[0].longitude.text.trim(),
            ),
            latitude: double.parse(
              controller.adressesForms[0].latitude.text.trim(),
            ),
          ),
          adressType: '',
        ),
      ],
      email: controller.email.text.trim(),
      phone: controller.phone.text.trim(),
      gender: controller.gender ?? 'm',
      //  image: images[i],
    );
  }

  @override
  PersonModel getDefaultModel() {
    return PersonModel(
      id: Uuid().v4(),
      name: '',
      createdAt: DateTime.now(),
      firstName: '',
      lastName: '',
      profileImageUrl: '',
      email: '',
      phone: '',
      gender: 'm',
      birthDate: null, // DateTime.now() - 18 * 365 * 24 * 60 * 60 * 1000, // 18 years ago
      addresses: [adressFormService.getDefaultModel()],
    );
  }

  @override
  Future<PersonModel> generateModel() {
    return seedService.getGeneratedPerson();
  }
}
