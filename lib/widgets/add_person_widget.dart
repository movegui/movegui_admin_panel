import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/methods/showBtmAlert.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/birthdate_picker.dart';
import 'package:movegui_admin_panel/widgets/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/gender_picker.dart';

class AddPersonWidget extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController adresseController;
  final TextEditingController telephonController;
  final TextEditingController emailController;
  final Function(File?) onImagePicked; // Add callback
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
    required this.onImagePicked,
    required this.formKey,
    required this.onBirthDateChanged,
    required this.onGenderChanged, // Pass callback
    required this.selectedGender
  });

  @override
  State<StatefulWidget> createState() => AddPersonWidgetState();
}

class AddPersonWidgetState extends State<AddPersonWidget> {
  Uint8List webImage = Uint8List(8);
  File? _pickedImage;
  // late PressingService pressingService;

  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _middleNameFocusNode;
  late FocusNode _adresseFocusNode;
  late FocusNode _telephonFocusNode;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    /*
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _adresseController = TextEditingController();
    _telephonController = TextEditingController();
    _emailController = TextEditingController();
    */

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: Size.width * 0.4,
          //   height: Size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
          ),
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
                      /*
                      Text(
                        'Ajouter un Contact:',
                        style: TextStyle(
                          fontSize: FontSize,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: AppColors.textColor,
                          decorationColor: AppColors.textColor,
                        ),
                      ),
                      */
                      SizedBox(
                        width: Responsive.isDesktop(context)
                            ? Size.width * 0.4
                            : Size.width * 0.5,
                        //  height: Size.height * 0.3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    hasIcon: false,
                                    hintText:
                                        'Veuillez saisir le nom du Contact',
                                    isNumber: false,
                                    controller: widget.firstNameController,
                                    textInputAction: TextInputAction.next,
                                    inputType: TextInputType.name,
                                    nextFocusNode: _lastNameFocusNode,
                                    labelText: 'Nom du Contact',
                                    icon: Icons.person,
                                    validator: (value) {
                                      return MyValidators.textNameValidator(
                                        value,
                                      );
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
                                      return MyValidators.textNameValidator(
                                        value,
                                      );
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
                                      return MyValidators.textNameValidator(
                                        value,
                                      );
                                    },
                                  ),

                                  CustomTextField(
                                    hasIcon: false,
                                    hintText:
                                        'Veuillez saisir l\'email du Contact',
                                    isNumber: false,
                                    controller: widget.emailController,
                                    textInputAction: TextInputAction.next,
                                    inputType: TextInputType.name,
                                    nextFocusNode: _telephonFocusNode,
                                    labelText: ' l\'email du Contact',
                                    icon: Icons.email,
                                    /*
                                                                onChanged: (data) {
                                                                  name = data.trim();
                                                                },
                                                                */
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
                                    /*
                                                              onChanged: (data) {
                                                                name = data.trim();
                                                              },
                                                              */
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
                                    /*
                                                                onChanged: (data) {
                                                                  name = data.trim();
                                                                },
                                                                */
                                    validator: (value) {
                                      return MyValidators.textValidator(value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Size.width * 0.03),
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: 250,
                                height: 300,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: _pickedImage != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: kIsWeb
                                                ? Image.memory(
                                                    webImage,
                                                    width: 240,
                                                    height: 220,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.file(
                                                    _pickedImage!,
                                                    width: 180,
                                                    height: 120,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _pickedImage = null;
                                                webImage = Uint8List(8);
                                              });
                                            },
                                            child: const Text(
                                              'Remove image',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: _pickImage,
                                            child: const Text(
                                              'Upload another',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: _pickImage,
                                            icon: const Icon(
                                              Icons.image_outlined,
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Chose an image',
                                                      style: TextStyle(
                                                        fontSize: FontSize,
                                                        color:
                                                            AppColors.textColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          widget.onImagePicked(selected);
          _pickedImage = selected;
        });
      } else {
        showBtmAlert(context, 'Veuillez choisir une Image');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          widget.onImagePicked(File(image.path)); // File('a');
          _pickedImage = File(image.path);
        });
      } else {
        showBtmAlert(context, 'Veuillez choisir une Image');
      }
    } else {
      showBtmAlert(context, 'Un problème est survenu !!!');
    }
  }
}
