
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/person_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address/address_list_widget.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
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
    final isDesktop = Responsive.isDesktop(context);
    return Center(
      child: Column(
        children: [
          _buildStoreWidget(context, isDesktop),
          SizedBox(height: WidgetConstants.sepWidget),
        ],
      ),
    );
  }

  Widget _buildStoreWidget(BuildContext context, bool isDesktop) {
    return Card(
      elevation: 3,
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        children: [
          !isDesktop
              ? _buildImagePicker(context, isDesktop)
              : SizedBox(width: 8, height: 8),
          if (isDesktop)
            Expanded(flex: 4, child: _buildFormFields(context))
          else
            _buildFormFields(context),
          const SizedBox(width: 8, height: 8),
          isDesktop
              ? _buildImagePicker(context, isDesktop)
              : SizedBox(width: 8, height: 8),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, bool isDesktop) {
    final imagePicker = ImagePickerWidget(
      webImage: personForm.webImage,
      pickedImage: personForm.pickedImage,
      onPickImage: onPickImage,
      onRemoveImage: onRemoveImage,
    );
    
    final validatedImagePicker = FormField<bool>(
      validator: (_) {
        return personForm.hasImage ? null : 'Veuillez choisir une image.';
      },
      builder: (field) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePicker,
          if (field.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                field.errorText!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );

    if (isDesktop) {
      return Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(
            right: WidgetConstants.sepWidgetHeight * 2,
          ),
          child: validatedImagePicker,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: validatedImagePicker,
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GenderPicker(
                onGenderChanged: (value) {
                  onGenderChanged.call(value);
                },
                gender: personForm.gender,
              ),
            ),
            SizedBox(width: 16), // optional spacing
            Expanded(
              child: BirthdatePicker(
                onBirthDateChanged: (value) {
                  onBirthDateChanged!.call(value);
                },
                birthDate: personForm.birthDate,
              ),
            ),
          ],
        ),

        InputNameWidget(
          nameController: personForm.firstName,
          nameFocusNode: personForm.firstNameFocusNode,
          hinterText: AppLocalizations.of(context)!.input_hint_first_name,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputNameWidget(
          nameController: personForm.lastName,
          nameFocusNode: personForm.lastNameFocusNode,
          hinterText: AppLocalizations.of(context)!.input_hint_last_name,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputEmailWidget(
          emailController: personForm.email,
          emailFocusNode: personForm.emailFocusNode,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputPhoneWidget(
          phoneController: personForm.phone,
          phoneFocusNode: personForm.phoneFocusNode,
        ),
        AddressListWidget(personForm: personForm),
        SeparatorWidget(height: WidgetConstants.sepWidget * 2),
      ],
    );
  }
}
