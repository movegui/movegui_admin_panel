import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/validator.dart';

class GenderPicker extends StatefulWidget {
  final String? gender;
  final ValueChanged<String?> onGenderChanged;

  const GenderPicker({super.key, required this.gender, required this.onGenderChanged});

  @override
  State<GenderPicker> createState() => _GenderAndBirthdatePickerState();
}

class _GenderAndBirthdatePickerState extends State<GenderPicker> {
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //  const SizedBox(height: 12),
            // Gender dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundColor,
                labelText: 'Genre',
                labelStyle: TextStyle(color: AppColors.textColor , fontSize: 18),
                border: InputBorder.none,
                /*
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textColor, // Set your desired border color
                    width: 1.0,
                  ),
                ),
                */
              ),
             style: TextStyle(color: AppColors.textColor, fontSize: 18),
              dropdownColor: AppColors.backgroundColor,
           //   focusColor: AppColors.selectionColor,
              iconEnabledColor: AppColors.textColor,
              value: _selectedGender,
              items: const [
                DropdownMenuItem(value: 'm', child: Text('Homme')),
                DropdownMenuItem(value: 'f', child: Text('Femme')),
                DropdownMenuItem(value: 'o', child: Text('Autre')),
              ],
              onChanged: (value) {
                setState(() => _selectedGender = value);
                widget.onGenderChanged.call(value!);
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
