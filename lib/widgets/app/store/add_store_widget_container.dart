import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address_widget.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';
import 'package:movegui_admin_panel/widgets/input/custom_text_field.dart';

class AddStoreWidgetContainer extends StatelessWidget {
  const AddStoreWidgetContainer({
    super.key,
    required this.formController,
    required this.storeConstants,
    required this.onAdressTypeChange,
    required this.onCommuneChange,
    this.textColor,
    required this.onPickImage,
    required this.onRemoveImage,
  });
  final StoreFormController formController;
  final StoreConstants storeConstants;
  final void Function(String?) onAdressTypeChange;
  final void Function(String?) onCommuneChange;
  final Color? textColor;

  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        //   border: Border.all(color: AppColors.backgroundColor)
        color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  controller: formController.name,
                  labelText: storeConstants.getNameLabelText(context),
                  hintText: storeConstants.getNameHinterText(context),
                  inputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  nextFocusNode: formController.descriptionFocus,
                  validator: MyValidators.textNameValidator,
                  icon: Icons.person,
                  hasIcon: true,
                  isNumber: false,
                ),
                CustomTextField(
                  controller: formController.description,
                  labelText: storeConstants.getDescripLabelText(context),
                  hintText: storeConstants.getDescripHinterText(context),
                  inputType: TextInputType.multiline,
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                  nextFocusNode: formController.addressForm.addressfocus,
                  validator: MyValidators.textValidator,
                  icon: Icons.message,
                  hasIcon: true,
                  isNumber: false,
                ),
                CustomTextField(
                  controller: formController.email,
                  labelText: storeConstants.getEmailLabelText(context),
                  hintText: storeConstants.getEmailHinterText(context),
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  nextFocusNode: formController.telephonFocus,
                  validator: MyValidators.emailValidator,
                  icon: Icons.email,
                  hasIcon: true,
                  isNumber: false,
                ),
                CustomTextField(
                  controller: formController.telephon,
                  labelText: storeConstants.getPhoneLabelText(context),
                  hintText: storeConstants.getPhoneHinterText(context),
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  //  nextFocusNode: contactFocus,
                  validator: MyValidators.phoneNumberValidator,
                  icon: Icons.phone,
                  hasIcon: true,
                  isNumber: true,
                ),
                AddressWidget(
                  addressController: formController.addressForm.address,
                  quartierController: formController.addressForm.quartier,
                  commune: formController.addressForm.selectedCommune,
                  onCommuneChange: onCommuneChange,
                  adresseType: formController.addressForm.addressSlectedType,
                  onAdressTypeChange: onAdressTypeChange,
                  addressfocusNode: formController.addressForm.addressfocus,
                  quartierFocusNode: formController.addressForm.quartierFocus,
                  longitudeController: formController.addressForm.longitude,
                  latitudeController: formController.addressForm.latitude,
                  longitudeFocusNode: formController.addressForm.longitudeFocus,
                  latitudeFocusNode: formController.addressForm.latitudeFocus,
                  isFullBorder: true,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // IMAGE PICKER UI
          Flexible(
            flex: 2,
            child: ImagePickerWidget(
              webImage: formController.webImage,
              pickedImage: formController.pickedImage,
              onPickImage: onPickImage,
              onRemoveImage: onRemoveImage,
            ),
          ),
        ],
      ),
    );
  }
}
