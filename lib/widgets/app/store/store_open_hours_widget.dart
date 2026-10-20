import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';

class StoreOpenHoursWidget extends StatelessWidget {
  final OpenHoursModel openingDay;
  final void Function(OpenHoursModel value) onHourChanged;

  const StoreOpenHoursWidget({
    super.key,
    required this.openingDay,
    required this.onHourChanged,
  });

  @override
  build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              openingDay.day,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // STATUS
          Expanded(flex: 2, child: _buildStatus(context, openingDay.isOpen)),

          // HOURS
          Expanded(
            child: openingDay.isOpen
                ? _buildTimeSlots(context, openingDay)
                : SizedBox(),
          ),

          // ACTION
          IconButton(
            tooltip: AppLocalizations.of(context)!.tooltip_btn_update,
            onPressed: () {
              _showEditDayDialog(context, openingDay);
            },
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildStatus(BuildContext context, bool isOpen) {
    final color = isOpen ? AppColors.active : AppColors.disabled;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          isOpen
              ? AppLocalizations.of(context)!.store_open
              : AppLocalizations.of(context)!.store_close,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Time slots
  // ---------------------------------------------------------------------------

  Widget _buildTimeSlots(BuildContext context, OpenHoursModel openingDay) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: openingDay.slots.map((slot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${_formatTime(slot.openingTime)}  →  '
            '${_formatTime(slot.closingTime)}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // Edit dialog
  // ---------------------------------------------------------------------------

  Future<void> _showEditDayDialog(
    BuildContext context,
    OpenHoursModel currentDay,
  ) async {
    bool isOpen = currentDay.isOpen;

    List<OpeningTimeSlot> slots = currentDay.slots
        .map(
          (slot) => OpeningTimeSlot(
            openingTime: slot.openingTime,
            closingTime: slot.closingTime,
          ),
        )
        .toList();

    if (slots.isEmpty) {
      slots = [
        OpeningTimeSlot(
          openingTime: const TimeOfDay(hour: 8, minute: 0),
          closingTime: const TimeOfDay(hour: 18, minute: 0),
        ),
      ];
    }

    final result = await showDialog<OpenHoursModel>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  const Icon(Icons.schedule_outlined),
                  const SizedBox(width: 10),
                  Text(currentDay.day),
                ],
              ),
              content: SizedBox(
                width: 520,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        isOpen
                            ? AppLocalizations.of(context)!.store_open
                            : AppLocalizations.of(context)!.store_close,
                      ),
                      subtitle: Text(
                        isOpen
                            ? AppLocalizations.of(
                                context,
                              )!.open_hours_open_title(
                                AppLocalizations.of(
                                  context,
                                )!.module_pressing_name,
                              )
                            : AppLocalizations.of(
                                context,
                              )!.open_hours_close_title(
                                AppLocalizations.of(
                                  context,
                                )!.module_pressing_name,
                              ),
                      ),
                      value: isOpen,
                      onChanged: (value) {
                        setDialogState(() {
                          isOpen = value;
                        });
                      },
                    ),

                    if (isOpen) ...[
                      const Divider(),
                      const SizedBox(height: 10),

                      ...slots.asMap().entries.map((entry) {
                        final slotIndex = entry.key;
                        final slot = entry.value;

                        return _buildEditableTimeSlot(
                          context,
                          slot: slot,
                          onOpeningChanged: (time) {
                            setDialogState(() {
                              slots[slotIndex] = slot.copyWith(
                                openingTime: time,
                              );
                            });
                          },
                          onClosingChanged: (time) {
                            setDialogState(() {
                              slots[slotIndex] = slot.copyWith(
                                closingTime: time,
                              );
                            });
                          },
                          onDelete: slots.length > 1
                              ? () {
                                  setDialogState(() {
                                    slots.removeAt(slotIndex);
                                  });
                                }
                              : null,
                        );
                      }),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            setDialogState(() {
                              slots.add(
                                OpeningTimeSlot(
                                  openingTime: const TimeOfDay(
                                    hour: 14,
                                    minute: 0,
                                  ),
                                  closingTime: const TimeOfDay(
                                    hour: 18,
                                    minute: 0,
                                  ),
                                ),
                              );
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: Text(
                            AppLocalizations.of(context)!.add_slot_title,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.btn_cancel_label),
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(
                      OpenHoursModel(
                        day: currentDay.day,
                        isOpen: isOpen,
                        slots: isOpen ? slots : [],
                      ),
                    );
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: Text(AppLocalizations.of(context)!.btn_register_label),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null) {
      onHourChanged.call(result);
    }
  }

  // ---------------------------------------------------------------------------
  // Editable slot
  // ---------------------------------------------------------------------------

  Widget _buildEditableTimeSlot(
    BuildContext context, {
    required OpeningTimeSlot slot,
    required ValueChanged<TimeOfDay> onOpeningChanged,
    required ValueChanged<TimeOfDay> onClosingChanged,
    VoidCallback? onDelete,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildTimeButton(
              context,
              label: AppLocalizations.of(context)!.store_opening,
              time: slot.openingTime,
              onChanged: onOpeningChanged,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.arrow_forward),
          ),

          Expanded(
            child: _buildTimeButton(
              context,
              label: AppLocalizations.of(context)!.store_closure,
              time: slot.closingTime,
              onChanged: onClosingChanged,
            ),
          ),

          const SizedBox(width: 5),

          if (onDelete != null)
            IconButton(
              tooltip: AppLocalizations.of(context)!.tooltip_delete,
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              style: Theme.of(context).iconButtonTheme.style!.copyWith(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.hovered)) {
                    return AppColors.selectionColor;
                  }

                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.selectionColor;
                  }

                  return AppColors.onPrimary;
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeButton(
    BuildContext context, {
    required String label,
    required TimeOfDay time,
    required ValueChanged<TimeOfDay> onChanged,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: time,
          switchToInputEntryModeIcon: Icon(
            Icons.keyboard_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          switchToTimerEntryModeIcon: Icon(
            Icons.access_time_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        );

        if (selectedTime != null) {
          onChanged(selectedTime);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          //   prefixIcon: const Icon(Icons.access_time),
          border: const OutlineInputBorder(),
        ),
        child: Text(
          _formatTime(time),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}
