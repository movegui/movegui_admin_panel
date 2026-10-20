import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/widgets/app/store/store_open_hours_widget.dart';

class StoreOpenHoursListWidget extends StatelessWidget {
  const StoreOpenHoursListWidget({
    super.key,
    required this.openingHours,
    required this.onHourChanged,
  });
  final List<OpenHoursModel> openingHours;
  final void Function(int index, OpenHoursModel value) onHourChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          ...openingHours.asMap().entries.map((entry) {
            final index = entry.key;
            final day = entry.value;

            return Column(
              children: [
                StoreOpenHoursWidget(
                  openingDay: day,
                  onHourChanged: (value) {
                    onHourChanged.call(index, value);
                  },
                ),
                if (index < openingHours.length - 1)
                  Divider(height: 1, color: colorScheme.outlineVariant),
              ],
            );
          }),
        ],
      ),
    );
  }
}
