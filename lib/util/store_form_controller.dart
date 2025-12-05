
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
import 'package:movegui_admin_panel/models/restaurant_model.dart';
import 'package:movegui_admin_panel/models/store_model.dart';

class StoreFormController {
    final name = TextEditingController();
  final adresse = TextEditingController();
  final telephon = TextEditingController();
  final email = TextEditingController();
  final description = TextEditingController();
  final nameFocus = FocusNode();
  final descriptionFocus = FocusNode() ;
  final adresseFocus = FocusNode();
  final emailFocus = FocusNode(); 
  final telephonFocus = FocusNode(); 
  final contacts = <PersonModel>[];
  final weeklyHours = <OpenHours>[];

  File? pickedImage;
  Uint8List? webImage;
  StoreTypeModel? selectedType;

  void dispose() {
    name.dispose();
    adresse.dispose();
    telephon.dispose();
    email.dispose();
    description.dispose();
  }
}