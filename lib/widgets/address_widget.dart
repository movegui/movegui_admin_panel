import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/movegui_platform.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/address_type_picker.dart';
import 'package:movegui_admin_panel/widgets/commune_widget_picker.dart';
import 'package:movegui_admin_panel/widgets/util/input_widget.dart';

class AddressWidget extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController quartierController;
  final TextEditingController? longitudeController;
  final TextEditingController? latitudeController;
  final String? commune;
  final String? adresseType;
  final void Function(String?) onAdressTypeChange;
  final void Function(String?) onCommuneChange;
  final FocusNode addressfocusNode;
  final FocusNode quartierFocusNode;
  final FocusNode? longitudeFocusNode;
  final FocusNode? latitudeFocusNode;
  final Color? textColor;

  const AddressWidget({
    super.key,
    required this.addressController,
    required this.quartierController,
    required this.commune,
    required this.onCommuneChange,
    required this.adresseType,
    required this.onAdressTypeChange,
    required this.addressfocusNode,
    required this.quartierFocusNode,
    required this.longitudeController,
    required this.latitudeController,
    required this.longitudeFocusNode,
    required this.latitudeFocusNode, 
    this.textColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)
                  ? 150
                  : MediaQuery.of(context).size.width * 0.3,
              child: AddressTypePicker(
                adresseType: adresseType,
                onAdressTypeChange: onAdressTypeChange,
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: addressController,
                focusNode: addressfocusNode,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_adress,
                textColor: textColor,
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
                commune: commune,
                onCommuneChange: onCommuneChange,
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: quartierController,
                focusNode: quartierFocusNode,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_quartier,
                 textColor: textColor,
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
                      controller: longitudeController!,
                      focusNode: longitudeFocusNode!,
                      icon: Icons.location_on,
                      hinterText: AppLocalizations.of(
                        context,
                      )!.input_hint_longitude,
                       textColor: textColor,
                    ),
                  ),
                  Expanded(
                    child: InputWidget(
                      controller: latitudeController!,
                      focusNode: latitudeFocusNode!,
                      icon: Icons.location_on,
                      hinterText: AppLocalizations.of(
                        context,
                      )!.input_hint_latitude,
                       textColor: textColor,
                    ),
                  ),
                ],
              )
            : SizedBox(),
            
      ],
    );
  }
}
