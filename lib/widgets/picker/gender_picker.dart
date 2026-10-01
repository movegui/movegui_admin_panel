import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
    
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                filled: true,
              
                labelText: 'Genre',
                labelStyle: TextStyle( fontSize: 18),
                border: InputBorder.none,
              ),
                
              value: _selectedGender,
              items:  [
                DropdownMenuItem(value: 'm', child: Text('Homme', style: Theme.of(context).textTheme.bodyMedium)),
                DropdownMenuItem(value: 'f', child: Text('Femme', style: Theme.of(context).textTheme.bodyMedium)),
                DropdownMenuItem(value: 'o', child: Text('Autre', style: Theme.of(context).textTheme.bodyMedium,)),
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
          ],
        ),
      ),
    );
  }
}
