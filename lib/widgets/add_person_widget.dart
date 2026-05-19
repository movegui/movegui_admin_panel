import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/address_widget.dart';
import 'package:movegui_admin_panel/widgets/birthdate_picker.dart';
import 'package:movegui_admin_panel/widgets/gender_picker.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';
import 'package:movegui_admin_panel/widgets/util/input_name_widget.dart';
import 'package:movegui_admin_panel/widgets/util/input_phone_widget.dart';

class AddPersonWidget extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController adresseController;
  final TextEditingController telephonController;
  final TextEditingController emailController;
  final TextEditingController quartierController;
  final TextEditingController longitudeController;
  final TextEditingController latitudeController;
  final Uint8List? webImage;
  final File? pickedImage;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final String? selectedGender;
  final bool? showBild;
  final String? adresseType;
  final void Function(String?) onAdressTypeChange;
  final String? commune;
  final ValueChanged<String?> onCommuneChange;
  final Color? textColor;

  const AddPersonWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.adresseController,
    required this.telephonController,
    required this.emailController,
    required this.quartierController,
    required this.formKey,
    required this.onBirthDateChanged,
    required this.onGenderChanged, // Pass callback
    required this.selectedGender,
    required this.webImage,
    required this.pickedImage,
    required this.onPickImage,
    required this.onRemoveImage,
    this.showBild = true,
    required this.adresseType,
    required this.onAdressTypeChange,
    required this.commune,
    required this.onCommuneChange,
    required this.longitudeController,
    required this.latitudeController, 
    this.textColor = AppColors.textColor,
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
  late FocusNode _quartierFocusNode;
  late FocusNode _longitudeFocusNode;
  late FocusNode _latitudeFocusNode;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _middleNameFocusNode = FocusNode();
    _adresseFocusNode = FocusNode();
    _telephonFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _quartierFocusNode = FocusNode();
    _longitudeFocusNode = FocusNode();
    _latitudeFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? buildDesktop(context)
        : buildMobile(context);
  }

  Widget buildDesktop(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 3,
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

                InputNameWidget(
                  nameController: widget.firstNameController,
                  nameFocusNode: _firstNameFocusNode,
                  hinterText: AppLocalizations.of(
                    context,
                  )!.input_hint_first_name,
                  textColor: widget.textColor,
                ),

                InputNameWidget(
                  nameController: widget.lastNameController,
                  nameFocusNode: _lastNameFocusNode,
                  hinterText: AppLocalizations.of(
                    context,
                  )!.input_hint_last_name,
                  textColor: widget.textColor,
                ),

                InputPhoneWidget(
                  phoneController: widget.telephonController,
                  phoneFocusNode: _telephonFocusNode,
                  textColor: widget.textColor,
                ),

                AddressWidget(
                  addressController: widget.adresseController,
                  adresseType: widget.adresseType,
                  onAdressTypeChange: widget.onAdressTypeChange,
                  addressfocusNode: _adresseFocusNode,
                  quartierFocusNode: _quartierFocusNode,
                  quartierController: widget.quartierController,
                  commune: widget.commune,
                  onCommuneChange: widget.onCommuneChange,
                  longitudeController: widget.longitudeController,
                  latitudeController: widget.latitudeController,
                  longitudeFocusNode: _longitudeFocusNode,
                  latitudeFocusNode: _latitudeFocusNode,
                  textColor: widget.textColor,
                ),
              ],
            ),
          ),
          const SizedBox(width: 80),
          widget.showBild == true
              ? Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: ImagePickerWidget(
                    webImage: widget.webImage,
                    pickedImage: widget.pickedImage,
                    onPickImage: widget.onPickImage,
                    onRemoveImage: widget.onRemoveImage,
                    //     width: 150,
                    //      height: 150,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          const SizedBox(width: 80),
          widget.showBild == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    width: size.width * 0.8,
                    child: ImagePickerWidget(
                      webImage: widget.webImage,
                      pickedImage: widget.pickedImage,
                      onPickImage: widget.onPickImage,
                      onRemoveImage: widget.onRemoveImage,
                      //     width: 150,
                      //      height: 150,
                    ),
                  ),
                )
              : SizedBox(),

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

          InputNameWidget(
            nameController: widget.firstNameController,
            nameFocusNode: _firstNameFocusNode,
            hinterText: AppLocalizations.of(context)!.input_hint_first_name,
            textColor: widget.textColor,
          ),

          InputNameWidget(
            nameController: widget.lastNameController,
            nameFocusNode: _lastNameFocusNode,
            hinterText: AppLocalizations.of(context)!.input_hint_last_name,
            textColor: widget.textColor,
          ),

          InputPhoneWidget(
            phoneController: widget.telephonController,
            phoneFocusNode: _telephonFocusNode,
            textColor: widget.textColor,
          ),

          AddressWidget(
            addressController: widget.adresseController,
            adresseType: widget.adresseType,
            onAdressTypeChange: widget.onAdressTypeChange,
            addressfocusNode: _adresseFocusNode,
            quartierFocusNode: _quartierFocusNode,
            quartierController: widget.quartierController,
            commune: widget.commune,
            onCommuneChange: widget.onCommuneChange,
            longitudeController: widget.longitudeController,
            latitudeController: widget.latitudeController,
            longitudeFocusNode: _longitudeFocusNode,
            latitudeFocusNode: _latitudeFocusNode,
            textColor: widget.textColor,
          ),
        ],
      ),
    );
  }
}
