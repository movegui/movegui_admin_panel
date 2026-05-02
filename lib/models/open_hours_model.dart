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

    Map<String, dynamic> toJson() => {
        'day': day,
        'openTime': openTime != null ? _timeOfDayToJson(openTime) : null,
        'closeTime': closeTime != null ? _timeOfDayToJson(closeTime) : null,
      };

  static Map<String, dynamic> _timeOfDayToJson(TimeOfDay? time) => {
        'hour': time!.hour,
        'minute': time.minute,
      };

  factory OpenHours.fromJson(Map<String, dynamic> json) => OpenHours(
        day: json['day'],
        openTime: _timeOfDayFromJson(json['openTime']),
        closeTime: _timeOfDayFromJson(json['closeTime']),
      );

  static TimeOfDay _timeOfDayFromJson(Map<String, dynamic> json) =>
      TimeOfDay(hour: json['hour'], minute: json['minute']);
}

      

      /*

  Map<String, dynamic> toJson() => {
    'day': day,
    'openTime': {'hours': openTime!.hour, 'minute': openTime!.minute},
    'closeTime': {'hours': closeTime!.hour, 'minute': closeTime!.minute},
  };

  factory OpenHours.fromJson(Map<String, dynamic> json) => OpenHours(
    day: json['day'],
    openTime: TimeOfDay(
      hour: json['openTime']['hours'],
      minute: json['openTime']['minute'],
    ),
    closeTime: TimeOfDay(
      hour: json['closeTime']['hours'],
      minute: json['closeTime']['minute'],
    ),
  );
  */

//}

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
