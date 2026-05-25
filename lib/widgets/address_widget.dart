import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/movegui_platform.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/widgets/picker/address_type_picker.dart';
import 'package:movegui_admin_panel/widgets/app/separator_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/commune_widget_picker.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';

class AddressWidget extends StatelessWidget {
  final AddressFormController addressForm;
  final void Function(String?) onAdressTypeChange;
  final void Function(String?) onCommuneChange;
  final Color? textColor;
  final bool? isFullBorder;
 // final GlobalKey<FormState> addAddressKey;

  const AddressWidget({
    super.key,
    required this.onCommuneChange,
    required this.onAdressTypeChange,
    this.textColor = AppColors.textColor,
    this.isFullBorder = false,
 //   required this.addAddressKey,
    required this.addressForm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
    //  key: addAddressKey,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)
                  ? 150
                  : MediaQuery.of(context).size.width * 0.3,
              child: AddressTypePicker(
                adresseType: addressForm.selectedType,
                onAdressTypeChange: onAdressTypeChange,
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: addressForm.address,
                focusNode: addressForm.addressFocusNode,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_adress,
                textColor: textColor,
                isFullBorder: isFullBorder,
                validator: (vaule) {
                  return MyValidators.textNameValidator(vaule);
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)
                  ? 150
                  : MediaQuery.of(context).size.width * 0.3,
              child: CommuneWidgetPicker(
                commune: addressForm.selectedMunicipality,
                onCommuneChange: onCommuneChange,
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: addressForm.district,
                focusNode: addressForm.districtFocus,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_quartier,
                textColor: textColor,
                isFullBorder: isFullBorder,
                validator: (vaule) {
                  return MyValidators.textNameValidator(vaule);
                },
              ),
            ),
          ],
        ),

        MoveguiPlatform.getCurrentPlatform() == MoveGuiPlatformEnum.WEB
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputWidget(
                      controller: addressForm.longitude,
                      focusNode: addressForm.longitudeFocusNode!,
                      icon: Icons.location_on,
                      hinterText: AppLocalizations.of(
                        context,
                      )!.input_hint_longitude,
                      textColor: textColor,
                      isFullBorder: isFullBorder,
                      textInputType: TextInputType.number,
                      validator: (vaule) {
                        return MyValidators.numberValidator(vaule);
                      },
                    ),
                  ),
                  Expanded(
                    child: InputWidget(
                      controller: addressForm.latitude,
                      focusNode: addressForm.latitudeFocusNode,
                      icon: Icons.location_on,
                      hinterText: AppLocalizations.of(
                        context,
                      )!.input_hint_latitude,
                      textColor: textColor,
                      isFullBorder: isFullBorder,
                      textInputType: TextInputType.number,
                      validator: (vaule) {
                        return MyValidators.numberValidator(vaule);
                      },
                    ),
                  ),
                ],
              )
            : SizedBox(),
        SeparatorWidget(height: 18),
      ],
    );
  }
}
