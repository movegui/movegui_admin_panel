import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/birthdate_picker.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/gender_picker.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';

class AddPersonWidget extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController adresseController;
  final TextEditingController telephonController;
  final TextEditingController emailController;
  final Uint8List? webImage;
  final File? pickedImage;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final String? selectedGender;

  const AddPersonWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.adresseController,
    required this.telephonController,
    required this.emailController,
    required this.formKey,
    required this.onBirthDateChanged,
    required this.onGenderChanged, // Pass callback
    required this.selectedGender,
    required this.webImage,
    required this.pickedImage,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  State<StatefulWidget> createState() => AddPersonWidgetState();
}

class AddPersonWidgetState extends State<AddPersonWidget> {
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _middleNameFocusNode;
  late FocusNode _adresseFocusNode;
  late FocusNode _telephonFocusNode;
  late FocusNode _emailFocusNode;


  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _middleNameFocusNode = FocusNode();
    _adresseFocusNode = FocusNode();
    _telephonFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;

    return Center(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GenderPicker(
                          onGenderChanged: (value) {
                            widget.onGenderChanged(value);
                          },
                          gender: widget.selectedGender,
                        ),
                      ),
                      SizedBox(width: 16), // optional spacing
                      Expanded(
                        child: BirthdatePicker(
                          onBirthDateChanged: (value) {
                            widget.onBirthDateChanged!(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? Size.width * 0.6
                        : Size.width * 0.4,
                    //  height: Size.height * 0.3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              CustomTextField(
                                hasIcon: false,
                                hintText: 'Veuillez saisir le nom du Contact',
                                isNumber: false,
                                controller: widget.firstNameController,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.name,
                                nextFocusNode: _lastNameFocusNode,
                                labelText: 'Nom du Contact',
                                icon: Icons.person,
                                validator: (value) {
                                  return MyValidators.textNameValidator(value);
                                },
                              ),

                              CustomTextField(
                                hasIcon: false,
                                hintText:
                                    'Veuillez saisir le prénom du Contact',
                                isNumber: false,
                                controller: widget.lastNameController,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.name,
                                nextFocusNode: _middleNameFocusNode,
                                labelText: 'Prénom du Contact',
                                icon: Icons.person,
                                validator: (value) {
                                  return MyValidators.textNameValidator(value);
                                },
                              ),

                              CustomTextField(
                                hasIcon: false,
                                hintText:
                                    'Veuillez saisir le Surnom du Contact',
                                isNumber: false,
                                controller: widget.middleNameController,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.name,
                                nextFocusNode: _middleNameFocusNode,
                                labelText: 'Surnom du Contact',
                                icon: Icons.person,
                                validator: (value) {
                                  return MyValidators.textNameValidator(value);
                                },
                              ),

                              CustomTextField(
                                hasIcon: false,
                                hintText: 'Veuillez saisir l\'email du Contact',
                                isNumber: false,
                                controller: widget.emailController,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.name,
                                nextFocusNode: _telephonFocusNode,
                                labelText: ' l\'email du Contact',
                                icon: Icons.email,
                                validator: (value) {
                                  return MyValidators.emailValidator(value);
                                },
                              ),
                              CustomTextField(
                                hasIcon: false,
                                hintText:
                                    'Veuillez saisir le telephone du Contact',
                                isNumber: false,
                                controller: widget.telephonController,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.name,
                                labelText: ' le telephone du Contact',
                                icon: Icons.phone,
                                validator: (value) {
                                  return MyValidators.phoneNumberValidator(
                                    value,
                                  );
                                },
                              ),
                              CustomTextField(
                                hasIcon: false,
                                hintText:
                                    'Veuillez saisir l\'adresse du Contact',
                                isNumber: false,
                                controller: widget.adresseController,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.name,
                                nextFocusNode: _emailFocusNode,
                                labelText: ' l\'adresse du Contact',
                                icon: Icons.home,
                                validator: (value) {
                                  return MyValidators.textValidator(value);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 80),
                        Flexible(
                          flex: 2,
                          child: ImagePickerWidget(
                            webImage: widget.webImage,
                            pickedImage: widget.pickedImage,
                            onPickImage: widget.onPickImage,
                            onRemoveImage: widget.onRemoveImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //  ),
    );
  }


}
