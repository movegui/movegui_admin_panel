import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/geo_cordinates_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/services/api_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_form_service.dart';
import 'package:movegui_admin_panel/services/interfaces/i_user_service.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:uuid/uuid.dart';

abstract class FormService<M extends StoreModel> implements IFormService {
  final ApiService api;

  FormService({required this.api});

  @override
  Future<List<UserModel>> getContacts(
    List<PersonFormController> controllers,
  ) async {
    return Future.wait(
      controllers.map((elem) async {
        return UserModel(
          updatedAt: DateTime.now(),
          id: Uuid().v4(),
          name: '',
          createdAt: DateTime.now(),
          username: null,
          isVerified: false,
          role: UserRole.Guest.name,
          personModel: PersonModel(
            id: const Uuid().v4(),
            firstName: elem.firstName.text.trim(),
            lastName: elem.lastName.text.trim(),
            name: "${elem.firstName.text.trim()} ${elem.lastName.text.trim()}",
            createdAt: DateTime.now(),
            middleName: elem.middleName.text.isEmpty
                ? null
                : elem.middleName.text.trim(),
            profileImageUrl: await _uploadImageToFirebase(
              elem.webImage!,
              elem.pickedImage,
            ),
            birthDate: elem.birthdate,
            addresses: [
              AdressModel(
                address: elem.addressesForms[0].address.text.trim(),
                id: Uuid().v4(),
                name: elem.addressesForms[0].selectedType,
                createdAt: DateTime.now(),
                district: elem.addressesForms[0].district.text.trim(),
                minucipality: elem.addressesForms[0].selectedMunicipality,
                zoneId:
                    '${elem.addressesForms[0].selectedMunicipality} _ ${elem.addressesForms[0].district.text.trim()} _ ${elem.addressesForms[0].address.text.trim()}',
                geoCordinates: GeoCordinatesModel(
                  longitude: double.parse(
                    elem.addressesForms[0].longitude.text.trim(),
                  ),
                  latitude: double.parse(
                    elem.addressesForms[0].latitude.text.trim(),
                  ),
                ),
              ),
            ],
            email: elem.email.text.trim(),
            phone: elem.phone.text.trim(),
            gender: elem.gender!,
            //  image: images[i],
          ),
        );
      }).toList(),
    );
  }

  Future<String?> _uploadImageToFirebase(
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
  Future<AdressModel> getAdresse(AddressFormController controller) async {
    return AdressModel(
      address: controller.address.text.trim(),
      id: Uuid().v4(),
      name: controller.address.text.trim(),
      createdAt: DateTime.now(),
      district: controller.district.text.trim(),
      minucipality: controller.selectedMunicipality,
      zoneId:
          '${controller.address.text.trim()}_${controller.district.text.trim()}_${controller.selectedMunicipality}',
    );
  }
}
