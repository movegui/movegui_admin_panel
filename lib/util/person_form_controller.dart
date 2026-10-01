import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';

class PersonFormController extends FormController<PersonModel> {
 //  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleName = TextEditingController();
  final adressesForms = [AddressFormController()];
  final email = TextEditingController();
  final phone = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final middleNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  String? gender = 'm';
  String? profileImageUrl;
  DateTime? birthDate;
  File? pickedImage;
  Uint8List? webImage;

  bool get hasImage =>
      pickedImage != null ||
      webImage != null ||
      (profileImageUrl?.isNotEmpty ?? false);

  void addAddress() {
    adressesForms.add(AddressFormController());
  }

  void removeAddress(int index) {
    if (adressesForms.length == 1) return;

    final addressForm = adressesForms.removeAt(index);
    addressForm.dispose();
  }

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    middleName.dispose();
    for (final adressForm in adressesForms) {
      adressForm.dispose();
    }
    email.dispose();
    phone.dispose();
  }

  void clear() {
    firstName.clear();
    lastName.clear();
    middleName.clear();
    for (final adressForm in adressesForms) {
      adressForm.clear();
    }
    email.clear();
    phone.clear();
    birthDate = null;
    profileImageUrl = null;
    pickedImage = null;
    webImage = null;
  }

  @override
  Future<void> setData(PersonModel model) async {
    firstName.text = model.firstName;
    lastName.text = model.lastName;
    middleName.text = model.middleName ?? '';
    profileImageUrl = model.profileImageUrl;
    adressesForms.asMap().entries.map((entry) async {
      final index = entry.key;
      final addressForm = entry.value;
      await addressForm.setData(model.addresses[index]!);
    }).toList();
    email.text = model.email!;
    phone.text = model.phone!;
    gender = model.gender;
    print('Setting birthDate: ${model.birthDate}');
  //  birthDate = model.birthDate;
  }

  @override
  bool isValid() {
    return isDataValid();
  }

  bool isDataValid() {
    for (int i = 0; i < adressesForms.length; i++) {
      if (!adressesForms[i].isValid()) {
        return false;
      }
    }

    return firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        adressesForms.isNotEmpty &&
        email.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        gender?.isNotEmpty == true &&
        birthDate != null &&
        hasImage;
  }
}
