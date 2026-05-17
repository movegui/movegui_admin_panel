import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/constants.dart';
import 'package:movegui_admin_panel/consts/validator.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

class CommuneWidgetPicker extends StatefulWidget {
  final String? commune;
  final ValueChanged<String?> onCommuneChange;

  const CommuneWidgetPicker({
    super.key,
    required this.commune,
    required this.onCommuneChange,
  });

  @override
  State<CommuneWidgetPicker> createState() => CommuneWidgetPickerState();
}

class CommuneWidgetPickerState extends State<CommuneWidgetPicker> {
  String? _selectedCommune;

  @override
  void initState() {
    super.initState();
    _selectedCommune = widget.commune;
  }

  @override
  Widget build(BuildContext context) {

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
                labelText: AppLocalizations.of(context)!.commune_title,
                labelStyle: TextStyle(color: AppColors.textColor, fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle(color: AppColors.textColor, fontSize: 12),
              dropdownColor: AppColors.backgroundColor,
              //   focusColor: AppColors.selectionColor,
              iconEnabledColor: AppColors.textColor,
              value: _selectedCommune,
              items: [
                DropdownMenuItem(value: 'di', child: Text(COMMUNE_DIXINN)),
                DropdownMenuItem(value: 'gb', child: Text(COMMUNE_GBESSIA)),
                DropdownMenuItem(value: 'ka', child: Text(COMMUNE_KALOUM)),
                DropdownMenuItem(value: 'kg', child: Text(COMMUNE_KAGBELEN)),
                DropdownMenuItem(value: 'ks', child: Text(COMMUNE_KASSA)),
                DropdownMenuItem(value: 'la', child: Text(COMMUNE_LAMBANYI)),
                DropdownMenuItem(value: 'ma', child: Text(COMMUNE_MATAM)),
                DropdownMenuItem(value: 'mn', child: Text(COMMUNE_MANEAH)),
                DropdownMenuItem(value: 'mt', child: Text(COMMUNE_MATOTO)),
                DropdownMenuItem(value: 'ra', child: Text(COMMUNE_RATOMA)),
                DropdownMenuItem(value: 'so', child: Text(COMMUNE_SONFONIA)),
                DropdownMenuItem(value: 'sn', child: Text(COMMUNE_SANOYAH)),
                DropdownMenuItem(value: 'to', child: Text(COMMUNE_TOMBOLIA)),
              ],

              onChanged: (value) {
                setState(() => _selectedCommune = value);
                widget.onCommuneChange.call(value!);
              },
              validator: (value) {
                return MyValidators.textValidator(value);
              },
            ),

            //   const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
