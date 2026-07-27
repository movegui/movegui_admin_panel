import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/l10n/app_localizations.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';
import 'package:movegui_admin_panel/responsive.dart';

class OpenHoursWidget extends StatefulWidget {
  const OpenHoursWidget({super.key, required this.onHoursChanged});
  final Function(List<OpenHoursModel>) onHoursChanged;

  @override
  // ignore: library_private_types_in_public_api
  WeeklyHoursScreenState createState() => WeeklyHoursScreenState();
}

class WeeklyHoursScreenState extends State<OpenHoursWidget> {
  late List<OpenHoursModel> weeklyHours;

  @override
  void initState() {
    super.initState();
    weeklyHours = AppConstants.daysOfWeek.map((day) {
      return OpenHoursModel(
        day: day,
        isClosed: true,
        openTime: null,
        closeTime: null,
      );
    }).toList();
  }

  Future<List<OpenHoursModel>> getOpenHours() async {
    return weeklyHours;
  }

  Future<void> resetOpenHours() async {
    weeklyHours = AppConstants.daysOfWeek.map((day) {
      return OpenHoursModel(
        day: day,
        isClosed: true,
        openTime: null,
        closeTime: null,
      );
    }).toList();
    updateParent();
  }

  void updateParent() {
    if (weeklyHours.isNotEmpty) {
      widget.onHoursChanged(weeklyHours); // Notify parent with the updated list
    }
  }

  void updateCheckboxParent(int index, OpenHoursModel? item) {
    if (weeklyHours.isNotEmpty && item != null) {
      setState(() {
        // Update the weeklyHours state directly
        weeklyHours[index] = OpenHoursModel(
          day: item.day,
          isClosed: item.isClosed,
          openTime: item.openTime,
          closeTime: item.closeTime,
        );
      });
      updateParent(); // Notify parent with the updated list
    }
  }

  Future<void> pickTime({required int index, required bool isOpenTime}) async {
    OpenHoursModel item = weeklyHours[index];

    final picked = await showTimePicker(
      context: context,
      initialTime: isOpenTime
          ? item.openTime ?? const TimeOfDay(hour: 9, minute: 0)
          : item.closeTime ?? const TimeOfDay(hour: 17, minute: 0),
    );

    if (picked != null) {
      setState(() {
        if (isOpenTime) {
          item.openTime = picked;
        } else {
          item.closeTime = picked;
        }
        updateParent(); // Notify parent after updating time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    double FontSize = Size.width < 600 ? 18 : 28;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: weeklyHours.length,
      itemBuilder: (context, index) {
        int first = index * 2;
        int second = first + 1;

        OpenHoursModel? item1 = first < weeklyHours.length
            ? weeklyHours[first]
            : null;
        OpenHoursModel? item2 = second < weeklyHours.length
            ? weeklyHours[second]
            : null;

        return Center(
          child: Container(
            width: Responsive.isDesktop(context) ? Size.width * 0.5 : double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: item1 != null
                      ? Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: !item1.isClosed,
                                      onChanged: (value) {
                                        setState(() {
                                          item1.isClosed = !(value ?? true);
                                          updateCheckboxParent(first, item1);
                                        });
                                      },
                                    ),
                                    Text(
                                     // item1.day,
                                     getDayText(first, context),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                if (!item1.isClosed)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () async => await pickTime(
                                          index: first,
                                          isOpenTime: true,
                                        ),
                                        child: Text(
                                          item1.openTime?.format(context) ??
                                              "--:--",
                                        ),
                                      ),
                                      const Text("to"),
                                      TextButton(
                                        onPressed: () async => await pickTime(
                                          index: first,
                                          isOpenTime: false,
                                        ),
                                        child: Text(
                                          item1.closeTime?.format(context) ??
                                              "--:--",
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: item2 != null
                      ? Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: !item2.isClosed,
                                      onChanged: (value) {
                                        setState(() {
                                          item2.isClosed = !(value ?? true);
                                          updateCheckboxParent(second, item2);
                                        });
                                      },
                                    ),
                                    Text(
                                     // item2.day,
                                      getDayText(second, context),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                if (!item2.isClosed)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () => pickTime(
                                          index: second,
                                          isOpenTime: true,
                                        ),
                                        child: Text(
                                          item2.openTime?.format(context) ??
                                              "--:--",
                                        ),
                                      ),
                                      const Text("to"),
                                      TextButton(
                                        onPressed: () => pickTime(
                                          index: second,
                                          isOpenTime: false,
                                        ),
                                        child: Text(
                                          item2.closeTime?.format(context) ??
                                              "--:--",
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getDayText(int index, BuildContext context) {
    switch(index){
      case 0: return AppLocalizations.of(context)!.day_lundi;
      case 1: return AppLocalizations.of(context)!.day_mardi;
      case 2: return AppLocalizations.of(context)!.day_mercredi;
      case 3: return AppLocalizations.of(context)!.day_jeudi;
      case 4: return AppLocalizations.of(context)!.day_vendredi;
      case 5: return AppLocalizations.of(context)!.day_samedi;
      case 6: return AppLocalizations.of(context)!.day_dimanche;
      default: return '';
    }

  }
}
