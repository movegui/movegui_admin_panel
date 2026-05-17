import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
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
      color: AppColors.backgroundColor,
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
              decoration:  InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundColor,
                labelText: AppLocalizations.of(context)!.input_hint_adress,
                labelStyle: TextStyle(color: AppColors.textColor, fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle(color: AppColors.textColor, fontSize: 12),
              dropdownColor: AppColors.backgroundColor,
              //   focusColor: AppColors.selectionColor,
              iconEnabledColor: AppColors.textColor,
              value: _selectedAdressType,
              items: [
                DropdownMenuItem(value: 'h', child: Text(home)),
                DropdownMenuItem(value: 'o', child: Text(office)),
                DropdownMenuItem(value: 'n', child: Text(neighbor)),
                DropdownMenuItem(value: 'ot', child: Text(other)),
              ],
              onChanged: (value) {
                setState(() => _selectedAdressType = value);
                widget.onAdressTypeChange.call(value!);
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
}
