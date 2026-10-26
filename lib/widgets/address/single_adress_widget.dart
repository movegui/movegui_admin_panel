import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/consts/widget_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/util/address_form_controller.dart';
import 'package:movegui_admin_panel/widgets/input/input_widget.dart';
import 'package:movegui_admin_panel/widgets/picker/address_type_picker.dart';
import 'package:movegui_admin_panel/widgets/picker/commune_widget_picker.dart';
import 'package:movegui_admin_panel/widgets/util/layout_buider_widget.dart';

class SingleAdressWidget extends StatelessWidget {
  final AddressFormController addressForm;
  final ValueChanged<String?> onAdressTypeChange;
  final ValueChanged<String?> onCommuneChange;
  final bool? isFullBorder;

  const SingleAdressWidget({
    super.key,
    required this.addressForm,
    required this.onAdressTypeChange,
    required this.onCommuneChange,
    this.isFullBorder,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Column(
      children: [
        _buildTypeFields(context, isDesktop),
        SizedBox(height: WidgetConstants.sepWidget * 0.5),

        InputWidget(
          controller: addressForm.address,
          focusNode: addressForm.addressFocusNode,
          prefixIcon: Icon(Icons.home),
          hintText: AppLocalizations.of(context)!.input_hint_adress,
          isFullBorder: isFullBorder ?? false,
          validator: (vaule) {
            return MyValidators.textNameValidator(vaule);
          },
        ),
        SizedBox(height: WidgetConstants.sepWidget * 1.5),
        InputWidget(
          controller: addressForm.district,
          focusNode: addressForm.districtFocus,
          prefixIcon: Icon(Icons.location_city),
          hintText: AppLocalizations.of(context)!.input_hint_quartier,
          isFullBorder: isFullBorder ?? false,
          validator: (vaule) {
            return MyValidators.textNameValidator(vaule);
          },
        ),
        SizedBox(height: WidgetConstants.sepWidget * 1.5),
        _buildCoordonnatesFields(context, isDesktop),
      ],
    );
  }

  Widget _buildTypeFields(BuildContext context, bool isDesktop) {
    return LayoutBuilderWidget(
      children: [
        AddressTypePicker(
          adresseType: addressForm.selectedType,
          onAdressTypeChange: onAdressTypeChange,
        ),
        CommuneWidgetPicker(
          commune: addressForm.selectedMunicipality,
          onCommuneChange: onCommuneChange,
        ),
      ],
    );
  }

  Widget _buildCoordonnatesFields(BuildContext context, bool isDesktop) {
    return LayoutBuilderWidget(
      children: [
        InputWidget(
          controller: addressForm.longitude,
          focusNode: addressForm.longitudeFocusNode,
          prefixIcon: Icon(Icons.location_on),
          hintText: AppLocalizations.of(context)!.input_hint_longitude,
          isFullBorder: isFullBorder ?? false,
          validator: (vaule) {
            return MyValidators.textNameValidator(vaule);
          },
        ),
        InputWidget(
          controller: addressForm.latitude,
          focusNode: addressForm.latitudeFocusNode,
          prefixIcon: Icon(Icons.location_on),
          hintText: AppLocalizations.of(context)!.input_hint_latitude,
          isFullBorder: isFullBorder ?? false,
          validator: (vaule) {
            return MyValidators.textNameValidator(vaule);
          },
        ),
      ],
    );
  }
}
