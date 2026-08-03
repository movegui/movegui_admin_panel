import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';

class StoreOpenHoursWidget extends StatelessWidget {
  final List<OpenHoursModel> weeklyHours;

  const StoreOpenHoursWidget({super.key, required this.weeklyHours});

  @override
  Widget build(BuildContext context) {
    final bool useRow = weeklyHours.length < 4;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.open_hours_title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),
            // ...weeklyHours.map((e) => OpenHoursCard(openHour: e, textColor: textColor,)),
            Wrap(
              //    spacing: 12,
              //    runSpacing: 12,
              children: weeklyHours.map((e) {
                return SizedBox(
                  width: weeklyHours.length < 4
                      ? 220
                      : MediaQuery.of(context).size.width - 32,
                  child: OpenHoursCard(openHour: e),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class OpenHoursCard extends StatelessWidget {
  final OpenHoursModel openHour;

  const OpenHoursCard({super.key, required this.openHour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: openHour.day.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  openHour.day,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
                openHour.openTime != null
                    ? Text(
                        openHour.openTime!.format(context),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Text(
                        '*',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                openHour.closeTime != null
                    ? Text(
                        openHour.closeTime!.format(context),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Text(
                        '*',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
              ],
            )
          : SizedBox(),
    );
  }
}
