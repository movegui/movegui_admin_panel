import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_colors.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';
import 'package:movegui_admin_panel/models/open_hours_model.dart';

class OpenHoursWidget extends StatefulWidget {
  const OpenHoursWidget({super.key, required this.onHoursChanged});
  final Function(List<OpenHours>) onHoursChanged;

  @override
  // ignore: library_private_types_in_public_api
  _WeeklyHoursScreenState createState() => _WeeklyHoursScreenState();
}

class _WeeklyHoursScreenState extends State<OpenHoursWidget> {
  late List<OpenHours> weeklyHours;

  @override
  void initState() {
    super.initState();
    weeklyHours = AppConstants.daysOfWeek.map((day) {
      return OpenHours(
        day: day,
        isClosed: true,
        openTime: null, // const TimeOfDay(hour: 5, minute: 0),
        closeTime: null, //const TimeOfDay(hour: 23, minute: 0),
      );
    }).toList();
    // updateParent();
  }

  void updateParent() {
    if (weeklyHours.isNotEmpty) {
      widget.onHoursChanged(weeklyHours);
    }
  }

    void updateCheckboxParent(int index, OpenHours? item) {
    if(weeklyHours.isNotEmpty){
        if(item!.isClosed){
          weeklyHours[index] = OpenHours(day: item.day, isClosed: true, openTime: null, closeTime: null);
          updateParent();
        }
        
    }
}

  Future<void> pickTime({required int index, required bool isOpenTime}) async {
    OpenHours item = weeklyHours[index];

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
        updateParent();
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
        // final item = weeklyHours[index];

        int first = index * 2;
        int second = first + 1;

        OpenHours? item1 = first < weeklyHours.length
            ? weeklyHours[first]
            : null;
        OpenHours? item2 = second < weeklyHours.length
            ? weeklyHours[second]
            : null;

        return   Center(
          child: Container(
            width: Size.width * 0.6,
            //   height: Size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor, //Colors.grey.withOpacity(0.3),
            ),
            child:Row(
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
                                      updateCheckboxParent(index, item1);
                                      updateParent();
                                    });
                                  },
                                ),
                                Text(
                                  item1.day,
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
                                      updateCheckboxParent(index, item1);
                                    });
                                  },
                                ),
                                Text(
                                  item2.day,
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
        )
          )
        );
      },
    );
  }
}
