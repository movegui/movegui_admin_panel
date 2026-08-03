import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdatePicker extends StatefulWidget {
  final DateTime? birthDate;
  final ValueChanged<DateTime?>? onBirthDateChanged;

  const BirthdatePicker({super.key, this.birthDate, this.onBirthDateChanged});

  @override
  State<BirthdatePicker> createState() => _GenderAndBirthdatePickerState();
}

class _GenderAndBirthdatePickerState extends State<BirthdatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.birthDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedDate ?? DateTime(now.year - 18);
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
      widget.onBirthDateChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? DateFormat('dd MMM yyyy').format(_selectedDate!)
        : 'Selectionner Date de Naissance';

    return Card(
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 12),
            // Birthdate picker
            InkWell(
              onTap: () => _pickDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  filled: true,

                  labelText: 'Date de Naissance',
                  labelStyle: TextStyle(fontSize: 22),
                  border: InputBorder.none,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedDate != null
                        ? Text(formattedDate, style: TextStyle(fontSize: 14))
                        : Flexible(
                            child: Text(
                              'Selectionner votre date de Naissance',
                              style: TextStyle(
                                
                                fontSize: 14,
                              ),
                            ),
                          ),
                    const Icon(
                      Icons.calendar_today,
                       
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
