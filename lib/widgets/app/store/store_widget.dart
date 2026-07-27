import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/store_form_controller.dart';
import 'package:movegui_admin_panel/widgets/address_widget.dart';
import 'package:movegui_admin_panel/widgets/app/add_contact_widget.dart';
import 'package:movegui_admin_panel/widgets/app/opens_hours_widget.dart';
import 'package:movegui_admin_panel/widgets/input/custom_text_field.dart';
import 'package:movegui_admin_panel/widgets/image_picker_widget.dart';

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
    return Responsive.isDesktop(context)
        ? buildDesktop(context)
        : buildMobile(context);
  }

  Widget buildDesktop(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Container(
            width: size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
             
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
                        nextFocusNode:
                            formController.addressForm.addressFocusNode,
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
                        controller: formController.phone,
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
                        onCommuneChange: onCommuneChange,
                        onAdressTypeChange: onAdressTypeChange,
                        isFullBorder: true,
                    //    addAddressKey: addAddressKey,
                        addressForm: formController.addressForm,
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
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: AddContactWidget(
        //      addContactKey: addContactKey,
              formControllers: formController.personForms,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: OpenHoursWidget(
              // key: addOpenHoursKey,
              onHoursChanged: (hours) {
                onHoursChanged(hours);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            //   height: Size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
             
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    width: size.width * 0.8,
                    child: ImagePickerWidget(
                      webImage: formController.webImage,
                      pickedImage: formController.pickedImage,
                      onPickImage: onPickImage,
                      onRemoveImage: onRemoveImage,
                    ),
                  ),
                ),
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
                  nextFocusNode: formController.addressForm.addressFocusNode,
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
                  controller: formController.phone,
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
                  onCommuneChange: onCommuneChange,
                  onAdressTypeChange: onAdressTypeChange,
                  isFullBorder: true,
            //      addAddressKey: addAddressKey,
                  addressForm: formController.addressForm,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: AddContactWidget(
              formControllers: formController.personForms,
          //    addContactKey: addContactKey,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: OpenHoursWidget(
              // key: addOpenHoursKey,
              onHoursChanged: (hours) {
                onHoursChanged(hours);
              },
            ),
          ),
        ],
      ),
    );
  }
}
