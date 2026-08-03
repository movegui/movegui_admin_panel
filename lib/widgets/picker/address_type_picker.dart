import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class AddressTypePicker extends StatefulWidget {
  final String? adresseType;
  final ValueChanged<String?> onAdressTypeChange;

  const AddressTypePicker({
    super.key,
    required this.adresseType,
    required this.onAdressTypeChange,
  });

  @override
  State<AddressTypePicker> createState() => AddressTypePickerState();
}

class AddressTypePickerState extends State<AddressTypePicker> {
  String? _selectedAdressType;

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
    return Card(
  //    color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const SizedBox(height: 12),
            // Gender dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
             //   fillColor: AppColors.backgroundColor,
                labelText: AppLocalizations.of(context)!.input_hint_adress,
                labelStyle: TextStyle(  fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle(  fontSize: 12),
           //   dropdownColor: AppColors.backgroundColor,
              //   focusColor: AppColors.selectionColor,
           //   iconEnabledColor: AppColors.textColor,
              value: _selectedAdressType,
              items: [
                DropdownMenuItem(value: 'h', child: Text(home)),
                DropdownMenuItem(value: 'o', child: Text(office)),
                DropdownMenuItem(value: 'n', child: Text(neighbor)),
                DropdownMenuItem(value: 'ot', child: Text(other)),
              ],
              onChanged: (value) {
                setState(() => _selectedAdressType = value);

                switch (value) {
                  case 'h':
                    widget.onAdressTypeChange.call(
                      AppLocalizations.of(context)!.address_home_title,
                    );
                  case 'o':
                    widget.onAdressTypeChange.call(
                      AppLocalizations.of(context)!.address_office_title,
                    );
                  case 'n':
                    widget.onAdressTypeChange.call(
                      AppLocalizations.of(context)!.address_neighbor_title,
                    );
                  case 'ot':
                    widget.onAdressTypeChange.call(
                      AppLocalizations.of(context)!.address_other_title,
                    );
                  default:
                    return widget.onAdressTypeChange.call('');
                }

                //    widget.onAdressTypeChange.call(getAddressTypeLabel(value!));
              },
              validator: (value) {
                MyValidators.textValidator(value);
                return null;
              },
            ),

            //   const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String getAddressTypeLabel(String value) {
    switch (value) {
      case 'h':
        return AppLocalizations.of(context)!.address_home_title;
      case 'o':
        return AppLocalizations.of(context)!.address_office_title;
      case 'n':
        return AppLocalizations.of(context)!.address_neighbor_title;
      case 'ot':
        return AppLocalizations.of(context)!.address_other_title;
      default:
        return '';
    }
  }
}
