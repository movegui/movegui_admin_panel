import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address/address_widget.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_email_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_name_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_phone_widget.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';

class StoreWidget extends StatelessWidget {
  final StoreFormController formController;
  final void Function(String?) onAdressTypeChange;
  final void Function(String?) onCommuneChange;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final StoreConstants storeConstants;
  final Function(List<OpenHoursModel>) onHoursChanged;

  const StoreWidget({
    super.key,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.storeConstants,
    required this.onAdressTypeChange,
    required this.onCommuneChange,
    required this.formController,
    required this.onHoursChanged,
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

  Widget _buildFormFields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputNameWidget(
          nameController: formController.name,
          labelText: storeConstants.getNameLabelText(context),
          hinterText: storeConstants.getNameHinterText(context),
          nextFocusNode: formController.descriptionFocus,
          icon: Icons.business,
          nameFocusNode: formController.nameFocus,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputWidget(
          controller: formController.description,
          labelText: storeConstants.getDescripLabelText(context),
          hintText: storeConstants.getDescripHinterText(context),
          textInputType: TextInputType.multiline,
          maxLines: 5,
          nextFocusNode: formController.addressForm.addressFocusNode,
          validator: MyValidators.textValidator,
          prefixIcon: Icon(Icons.message),
       //   isNumber: false,
          focusNode: formController.descriptionFocus,
          onChange: (String value) {},
          isFullBorder: true,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputEmailWidget(
          emailController: formController.email,
          labelText: storeConstants.getEmailLabelText(context),
          nextFocusNode: formController.telephonFocus,
          emailFocusNode: formController.emailFocus,
        ),
        SizedBox(height: WidgetConstants.sepWidget * 2),
        InputPhoneWidget(
          phoneController: formController.phone,
          labelText: storeConstants.getPhoneLabelText(context),
          phoneFocusNode: formController.telephonFocus,
        ),
        SizedBox(height: WidgetConstants.sepWidget),
        AddressWidget(
          onCommuneChange: onCommuneChange,
          onAdressTypeChange: onAdressTypeChange,
          isFullBorder: true,
          addressForm: formController.addressForm,
          onChange: (value) {},
          defaultId: '',
          onDefaultAdressChange: (String? value) {},
        ),
      ],
    );
  }

  Widget _buildImagePicker(BuildContext context, bool isDesktop) {
    final imagePicker = ImagePickerWidget(
      webImage: formController.webImage,
      pickedImage: formController.pickedImage,
      onPickImage: onPickImage,
      onRemoveImage: onRemoveImage,
    );

    if (isDesktop) {
      return Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(
            right: WidgetConstants.sepWidgetHeight * 2,
          ),
          child: imagePicker,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        width: 200, //MediaQuery.sizeOf(context).width * 0.8,
        child: imagePicker,
      ),
    );
  }
}
