import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_email_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/birthdate_picker.dart';
import 'package:movegui_admin_panel/widgets/picker/gender_picker.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_name_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_phone_widget.dart';

class AddPersonWidget extends StatelessWidget {
  final PersonFormController personForm;
  final ValueChanged<String?> onCommuneChange;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final void Function(String?) onAdressTypeChange;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final bool? showBild;

  const AddPersonWidget({
    super.key,
    required this.onBirthDateChanged,
    required this.onGenderChanged, // Pass callback
    required this.onPickImage,
    required this.onRemoveImage,
    this.showBild = true,
    required this.onAdressTypeChange,
    required this.onCommuneChange,
    required this.personForm,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? buildDesktop(context)
        : buildMobile(context);
  }

  Widget buildDesktop(BuildContext context) {
    return Center(
      //   key: personKey,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GenderPicker(
                        onGenderChanged: (value) {
                          onGenderChanged(value);
                        },
                        gender: personForm.gender,
                      ),
                    ),
                    SizedBox(width: 16), // optional spacing
                    Expanded(
                      child: BirthdatePicker(
                        onBirthDateChanged: (value) {
                          onBirthDateChanged!(value);
                        },
                      ),
                    ),
                  ],
                ),

                InputNameWidget(
                  nameController: personForm.firstName,
                  nameFocusNode: personForm.firstNameFocusNode,
                  hinterText: AppLocalizations.of(
                    context,
                  )!.input_hint_first_name,
                ),

                InputNameWidget(
                  nameController: personForm.lastName,
                  nameFocusNode: personForm.lastNameFocusNode,
                  hinterText: AppLocalizations.of(
                    context,
                  )!.input_hint_last_name,
                ),

                InputEmailWidget(
                  emailController: personForm.email,
                  emailFocusNode: personForm.emailFocusNode,
                ),

                InputPhoneWidget(
                  phoneController: personForm.phone,
                  phoneFocusNode: personForm.phoneFocusNode,
                ),

                AddressWidget(
                  onAdressTypeChange: onAdressTypeChange,
                  onCommuneChange: onCommuneChange,
                  //       addAddressKey: addAddressKey,
                  addressForm: personForm.addressesForms[0],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          showBild == true
              ? Flexible(
                  flex: 2,
                  child: ImagePickerWidget(
                    webImage: personForm.webImage,
                    pickedImage: personForm.pickedImage,
                    onPickImage: onPickImage,
                    onRemoveImage: onRemoveImage,
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
          showBild == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    width: size.width * 0.8,
                    child: ImagePickerWidget(
                      webImage: personForm.webImage,
                      pickedImage: personForm.pickedImage,
                      onPickImage: onPickImage,
                      onRemoveImage: onRemoveImage,
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
                    onGenderChanged(value);
                  },
                  gender: personForm.gender,
                ),
              ),
              SizedBox(width: 16), // optional spacing
              Expanded(
                child: BirthdatePicker(
                  onBirthDateChanged: (value) {
                    onBirthDateChanged!(value);
                  },
                ),
              ),
            ],
          ),

          InputNameWidget(
            nameController: personForm.firstName,
            nameFocusNode: personForm.firstNameFocusNode,
            hinterText: AppLocalizations.of(context)!.input_hint_first_name,
          ),

          InputNameWidget(
            nameController: personForm.lastName,
            nameFocusNode: personForm.lastNameFocusNode,
            hinterText: AppLocalizations.of(context)!.input_hint_last_name,
          ),

          InputEmailWidget(
            emailController: personForm.email,
            emailFocusNode: personForm.emailFocusNode,
          ),

          InputPhoneWidget(
            phoneController: personForm.phone,
            phoneFocusNode: personForm.phoneFocusNode,
          ),

          AddressWidget(
            onAdressTypeChange: onAdressTypeChange,
            onCommuneChange: onCommuneChange,
            addressForm: personForm.addressesForms[0],
          ),
        ],
      ),
    );
  }
}
