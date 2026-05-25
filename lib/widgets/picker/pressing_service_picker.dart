import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/pressing/pressing_service_type_model.dart';

class PressingServicePicker extends StatefulWidget {
  final PressingServiceTypeModel? service;
  final ValueChanged<PressingServiceTypeModel?> onServiceChange;
  final Color? backgroundColor;
  final Color? textColor;

  const PressingServicePicker({
    super.key,
    required this.service,
    required this.onServiceChange,
    this.backgroundColor = AppColors.backgroundColor,
    this.textColor = AppColors.textColor,
  });

  @override
  State<PressingServicePicker> createState() => PressingServicePickerState();
}

class PressingServicePickerState extends State<PressingServicePicker> {
  PressingServiceTypeModel? _selectedService;

  @override
  void initState() {
    super.initState();
    _selectedService = widget.service;
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
            DropdownButtonFormField<PressingServiceTypeModel>(
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.backgroundColor,
                labelText: AppLocalizations.of(context)!.commune_title,
                labelStyle: TextStyle(color: widget.textColor, fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle(color: widget.textColor, fontSize: 12),
              dropdownColor: widget.backgroundColor,
              iconEnabledColor: widget.textColor,
              value: _selectedService,
              items: AppConstants.getPressingServices(context).map((elem) {
                return DropdownMenuItem(
                  value: elem,
                  child: Text(
                    elem.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedService = value);
                widget.onServiceChange.call(value);
              },
            ),

            /*
            DropdownButtonFormField<PressingServiceTypeModel>(
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.backgroundColor,
                labelText: AppLocalizations.of(context)!.commune_title,
                labelStyle: TextStyle(color: widget.textColor, fontSize: 12),
                border: InputBorder.none,
              ),
              style: TextStyle(color: widget.textColor, fontSize: 12),
              dropdownColor: widget.backgroundColor,
              iconEnabledColor: widget.textColor,
              value: _selectedService,
              items: AppConstants.getPressingServices(context).map((elem) {
                return DropdownMenuItem(value: elem, child: Text(elem.name));
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedService = value);
                widget.onServiceChange.call(value);
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}
