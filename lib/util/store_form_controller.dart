
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/person_model.dart';
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
  List<PersonModel> contacts = [];
  List<OpenHours> weeklyHours = [];
  File? pickedImage;
  Uint8List? webImage;
  StoreTypeModel? selectedType;
  CategoriesModel? categoriesModel;

  void dispose() {
    name.dispose();
    adresse.dispose();
    telephon.dispose();
    email.dispose();
    description.dispose();
  }

  void clear(){
    name.clear();
    adresse.clear();
    description.clear();
    telephon.clear();
    email.clear();
    pickedImage = null;
    webImage = null;
    //contacts.clear();
    //weeklyHours.clear();
   // pickedImage = null;
   // webImage = null;
    ///dispose();

  }

 
}