import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/consts/app_constants.dart';

class OpenHours {
  final String day; // e.g., "Monday"
   TimeOfDay? openTime;
   TimeOfDay? closeTime;
   bool isClosed;

  OpenHours({
    required this.day,
    this.openTime,
    this.closeTime,
    this.isClosed = false,
  });
   


}

class Schedule {
  final List<String> closedDays;
  final TimeOfDay defaultOpen;
  final TimeOfDay defaultClose;

  Schedule({
    required this.closedDays,
    required this.defaultOpen,
    required this.defaultClose,
  });

  List<OpenHours> get weeklyHours {
    return AppConstants.daysOfWeek.map((day) {
      bool isClosed = closedDays.contains(day);
      return OpenHours(
        day: day,
        openTime: isClosed ? null : defaultOpen,
        closeTime: isClosed ? null : defaultClose,
        isClosed: isClosed,
      );
    }).toList();
  }
}
