import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/address_type_picker.dart';
import 'package:movegui_admin_panel/widgets/commune_widget_picker.dart';
import 'package:movegui_admin_panel/widgets/util/input_widget.dart';

class AddressWidget extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController quartierController;
  final String? commune;
  final String? adresseType;
  final void Function(String?) onAdressTypeChange;
  final void Function(String?) onCommuneChange;
  final FocusNode focusNode;

  const AddressWidget({
    super.key,
    required this.addressController,
    required this.quartierController,
    required this.commune,
    required this.onCommuneChange,
    required this.adresseType,
    required this.onAdressTypeChange,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)? 150 : MediaQuery.of(context).size.width * 0.3,
              child: AddressTypePicker(
                adresseType: adresseType,
                onAdressTypeChange: onAdressTypeChange,
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: addressController,
                focusNode: focusNode,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_adress,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.isDesktop(context)? 150 : MediaQuery.of(context).size.width * 0.3,
              child: CommuneWidgetPicker(
                commune: commune,
                onCommuneChange: onCommuneChange,
              ),
            ),
            Expanded(
              child: InputWidget(
                controller: quartierController,
                focusNode: focusNode,
                icon: Icons.home,
                hinterText: AppLocalizations.of(context)!.input_hint_quartier,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
