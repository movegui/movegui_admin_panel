import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';

class StoreWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController adresseController;
  final TextEditingController emailController;
  final TextEditingController telephonController;

  final FocusNode nameFocus;
  final FocusNode descriptionFocus;
  final FocusNode adresseFocus;
  final FocusNode emailFocus;
  final FocusNode telephonFocus;

  final Uint8List? webImage;
  final File? pickedImage;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final StoreConstants storeConstants;

  const StoreWidget({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.adresseController,
    required this.emailController,
    required this.telephonController,
    required this.nameFocus,
    required this.descriptionFocus,
    required this.adresseFocus,
    required this.emailFocus,
    required this.telephonFocus,
    required this.webImage,
    required this.pickedImage,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.storeConstants,
  });

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return Center(
      child: Container(
        width: Size.width * 0.6,
        //   height: Size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    labelText: storeConstants.getNameLabelText(),
                    hintText: storeConstants.getNameHinterText(),
                    inputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: descriptionFocus,
                    validator: MyValidators.textNameValidator,
                    icon: Icons.person,
                    hasIcon: true,
                    isNumber: false,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    labelText: storeConstants.getDescripLabelText(),
                    hintText: storeConstants.getDescripHinterText(),
                    inputType: TextInputType.multiline,
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: adresseFocus,
                    validator: MyValidators.textValidator,
                    icon: Icons.message,
                    hasIcon: true,
                    isNumber: false,
                  ),
                  CustomTextField(
                    controller: adresseController,
                    labelText: storeConstants.getAdressLabeltext(),
                    hintText: storeConstants.getAdressHinterText(),
                    inputType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: emailFocus,
                    validator: MyValidators.textValidator,
                    icon: Icons.home,
                    hasIcon: true,
                    isNumber: false,
                  ),
                  CustomTextField(
                    controller: emailController,
                    labelText: storeConstants.getEmailLabelText(),
                    hintText: storeConstants.getEmailHinterText(),
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: telephonFocus,
                    validator: MyValidators.emailValidator,
                    icon: Icons.email,
                    hasIcon: true,
                    isNumber: false,
                  ),
                  CustomTextField(
                    controller: telephonController,
                    labelText: storeConstants.getPhoneLabelText(),
                    hintText: storeConstants.getPhoneHinterText(),
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    //  nextFocusNode: contactFocus,
                    validator: MyValidators.phoneNumberValidator,
                    icon: Icons.phone,
                    hasIcon: true,
                    isNumber: true,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 80),

            // IMAGE PICKER UI
            Flexible(
              flex: 2,
              child: ImagePickerWidget(
                webImage: webImage,
                pickedImage: pickedImage,
                onPickImage: onPickImage,
                onRemoveImage: onRemoveImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
