import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/models/categories_model.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/models/store/store_model.dart';
import 'package:movegui_admin_panel/models/user_model.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/util/form_controller.dart';
import 'package:uuid/uuid.dart';

abstract class StoreFormController<T extends StoreModel>
    extends FormController<T> {
       String? id = Uuid().v4();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final description = TextEditingController();
  final nameFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final emailFocus = FocusNode();
  final telephonFocus = FocusNode();
  final addressForm = AddressFormController();
 // final userForms = [UserFormController()];
  List<UserModel>? staff = [];
  List<OpenHoursModel> weeklyHours = [];
  File? pickedImage;
  Uint8List? webImage;
  StoreTypeModel? selectedType;
  CategoriesModel? categoriesModel;
  AdressModel? adressModel;
  double? rating;
  int? reviewCount;
  String? imageUrl;

  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    description.dispose();
    addressForm.dispose();
  }

    bool get hasImage =>
      pickedImage != null ||
      webImage != null ;

  void clear() {
    name.clear();
    description.clear();
    phone.clear();
    email.clear();
    addressForm.clear();
    pickedImage = null;
    webImage = null;
    staff!.clear();
    weeklyHours.clear();
    selectedType = null;
    categoriesModel = null;
    adressModel = null;
    rating = null;
    reviewCount = null;
  }

  @override
  Future<void> setData(T model) async {
    id = model.id;
    name.text = model.name;
    phone.text = model.phone;
    email.text = model.email;
    description.text = model.description ?? '';
    await addressForm.setData(model.address);
    staff = model.staff ?? [];
    imageUrl = model.imageUrl;
    rating = model.rating ?? 0.0;
    reviewCount = model.reviewCount ?? 0;
    weeklyHours = model.weeklyHours;
  }
}
