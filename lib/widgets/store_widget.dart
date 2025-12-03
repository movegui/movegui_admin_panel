import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/services/register_services.dart';
import 'package:movegui_admin_panel/services/restaurant_type_service.dart';
import 'package:movegui_admin_panel/services/restaurants_service.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                labelText: 'Nom du Restaurant',
                hintText: 'Veuillez saisir le nom du Restaurant',
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
                labelText: 'Description',
                hintText: 'Veuillez saisir la description du Restaurant',
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
                labelText: 'Adresse',
                hintText: 'Veuillez saisir l\'adresse du Restaurant',
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
                labelText: 'Email',
                hintText: 'Veuillez saisir l\'email du Restaurant',
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
                labelText: 'Téléphone',
                hintText: 'Veuillez saisir le téléphone du Restaurant',
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

        const SizedBox(width: 20),

        // IMAGE PICKER UI
        Flexible(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 250,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: pickedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: onPickImage,
                        icon: const Icon(Icons.image),
                      ),
                      Text(
                        'Choisir une image',
                        style: TextStyle(
                          fontSize: FontSize,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: webImage != null
                            ? Image.memory(
                                webImage!,
                                width: 250,
                                height: 220,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                pickedImage!,
                                width: 220,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                      ),
                      TextButton(
                        onPressed: onRemoveImage,
                        child: const Text(
                          'supprimer',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: onPickImage,
                        child: const Text(
                          'Changer l\'image',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
