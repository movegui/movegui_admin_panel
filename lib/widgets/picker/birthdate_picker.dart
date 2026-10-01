import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';

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

  Future<void> _pickDate(
    BuildContext context,
    FormFieldState<DateTime?> field,
  ) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = field.value ?? DateTime(now.year - 18);
    final DateTime firstDate = DateTime(1900);
    final DateTime lastDate = now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        final datePickerTheme = Theme.of(context).copyWith(
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              foregroundColor: const WidgetStatePropertyAll(AppColors.primary),
            ),
          ),
        );

        return Theme(data: datePickerTheme, child: child!);
      },
    );

    if (picked != null) {
      field.didChange(picked);
      setState(() => _selectedDate = picked);
      widget.onBirthDateChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyMedium;

    return FormField<DateTime?>(
      initialValue: widget.birthDate ?? _selectedDate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value == null
          ? AppLocalizations.of(context)!.input_hint_birthdate_error_msg
          : null,
      builder: (field) {
        final selectedDate = field.value;
        final formattedDate = selectedDate != null
            ? DateFormat('dd MMM yyyy').format(selectedDate)
            : AppLocalizations.of(context)!.input_hint_birthdate;

        return Card(
          margin: const EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _pickDate(context, field),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      labelText: AppLocalizations.of(context)!.label_birthdate,
                      labelStyle: theme,
                      border: InputBorder.none,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        selectedDate != null
                            ? Text(
                                formattedDate,
                                style: const TextStyle(fontSize: 14),
                              )
                            : Flexible(
                                child: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.input_hint_select_birthdate,
                                ),
                              ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                if (field.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      field.errorText!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
