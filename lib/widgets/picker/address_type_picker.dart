import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';
import 'package:movegui_admin_panel/responsive.dart';
import 'package:movegui_admin_panel/widgets/util/form_card_widget.dart';

class AddressTypePicker extends StatefulWidget {
  final AdressType? adresseType;
  final ValueChanged<AdressType?> onAdressTypeChange;

  const AddressTypePicker({
    super.key,
    required this.adresseType,
    required this.onAdressTypeChange,
  });

  @override
  State<AddressTypePicker> createState() => AddressTypePickerState();
}

class AddressTypePickerState extends State<AddressTypePicker> {
  AdressType? _selectedAdressType;

  @override
  void initState() {
    super.initState();
    _selectedAdressType = widget.adresseType;
  }

  @override
  Widget build(BuildContext context) {
    String home = AppLocalizations.of(context)!.address_home_title;
    String office = AppLocalizations.of(context)!.address_office_title;
    String neighbor = AppLocalizations.of(context)!.address_neighbor_title;
    String other = AppLocalizations.of(context)!.address_other_title;
    final style = Responsive.isDesktop(context)
        ? Theme.of(context).textTheme.bodyMedium
        : Theme.of(context).textTheme.bodySmall;
    final labelStyle = Responsive.isDesktop(context)
        ? Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )
        : Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          );
    return FormCardWidget(
      child: DropdownButtonFormField<AdressType>(
        decoration: InputDecoration(
          filled: true,
          labelText: AppLocalizations.of(context)!.input_hint_adress,
          labelStyle: labelStyle,
          border: InputBorder.none,
          floatingLabelStyle: labelStyle,
        ),
        value: _selectedAdressType,
        items: [
          DropdownMenuItem(
            value: AdressType.home,
            child: Text(home, style: style),
          ),
          DropdownMenuItem(
            value: AdressType.office,
            child: Text(office, style: style),
          ),
          DropdownMenuItem(
            value: AdressType.neighbor,
            child: Text(neighbor, style: style),
          ),
          DropdownMenuItem(
            value: AdressType.other,
            child: Text(other, style: style),
          ),
        ],
        onChanged: (value) {
          setState(() => _selectedAdressType = value);

          switch (value) {
            case AdressType.home:
              widget.onAdressTypeChange.call(AdressType.home);
            case AdressType.office:
              widget.onAdressTypeChange.call(AdressType.office);
            case AdressType.neighbor:
              widget.onAdressTypeChange.call(
                //AppLocalizations.of(context)!.address_neighbor_title,
                AdressType.neighbor,
              );
            case AdressType.other:
              widget.onAdressTypeChange.call(AdressType.other);
            default:
              return widget.onAdressTypeChange.call(AdressType.other);
          }
        },
        validator: (value) {
          return MyValidators.textValidator(value!.name);
        },
      ),
    );
  }

  String getAddressTypeLabel(AdressType adressType) {
    switch (adressType) {
      case AdressType.home:
        return AppLocalizations.of(context)!.address_home_title;
      case AdressType.office:
        return AppLocalizations.of(context)!.address_office_title;
      case AdressType.neighbor:
        return AppLocalizations.of(context)!.address_neighbor_title;
      case AdressType.other:
        return AppLocalizations.of(context)!.address_other_title;
    }
  }
}
