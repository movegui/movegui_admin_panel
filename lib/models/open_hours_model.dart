import 'package:flutter/material.dart';

class OpenHoursModel {
  final String day;
  bool isOpen;
  final List<OpeningTimeSlot> slots;

  OpenHoursModel({
    required this.day,
    this.isOpen = false,
    List<OpeningTimeSlot>? slots,
  }) : slots = slots ?? const [];

  bool get isClosed => !isOpen;
  set isClosed(bool value) => isOpen = !value;

  TimeOfDay? get openTime => slots.isNotEmpty ? slots.first.openingTime : null;
  set openTime(TimeOfDay? value) {
    if (value == null) {
      if (slots.isNotEmpty) {
        slots[0] = slots.first.copyWith(
          openingTime: const TimeOfDay(hour: 0, minute: 0),
        );
      }
      return;
    }

    if (slots.isEmpty) {
      slots.add(
        OpeningTimeSlot(
          openingTime: value,
          closingTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      );
      return;
    }

    slots[0] = slots.first.copyWith(openingTime: value);
  }

  TimeOfDay? get closeTime => slots.isNotEmpty ? slots.first.closingTime : null;
  set closeTime(TimeOfDay? value) {
    if (value == null) {
      if (slots.isNotEmpty) {
        slots[0] = slots.first.copyWith(
          closingTime: const TimeOfDay(hour: 0, minute: 0),
        );
      }
      return;
    }

    if (slots.isEmpty) {
      slots.add(
        OpeningTimeSlot(
          openingTime: const TimeOfDay(hour: 9, minute: 0),
          closingTime: value,
        ),
      );
      return;
    }

    slots[0] = slots.first.copyWith(closingTime: value);
  }

  OpenHoursModel copyWith({
    String? day,
    bool? isOpen,
    List<OpeningTimeSlot>? slots,
  }) {
    return OpenHoursModel(
      day: day ?? this.day,
      isOpen: isOpen ?? this.isOpen,
      slots: slots ?? this.slots.map((slot) => slot.copyWith()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'isOpen': isOpen,
    'slots': slots.map((slot) => slot.toJson()).toList(),
    //  'openTime': openTime != null ? _timeOfDayToJson(openTime) : null,
    //  'closeTime': closeTime != null ? _timeOfDayToJson(closeTime) : null,
  };

  factory OpenHoursModel.fromJson(Map<String, dynamic> json) {
    final rawSlots = json['slots'];
    final parsedSlots = rawSlots is List
        ? rawSlots
              .whereType<Map<String, dynamic>>()
              .map(OpeningTimeSlot.fromJson)
              .toList()
        : <OpeningTimeSlot>[];

    if (parsedSlots.isEmpty &&
        (json['openTime'] != null || json['closeTime'] != null)) {
      parsedSlots.add(
        OpeningTimeSlot(
          openingTime: json['openTime'] != null
              ? _timeOfDayFromJson(json['openTime'])
              : const TimeOfDay(hour: 9, minute: 0),
          closingTime: json['closeTime'] != null
              ? _timeOfDayFromJson(json['closeTime'])
              : const TimeOfDay(hour: 17, minute: 0),
        ),
      );
    }

    return OpenHoursModel(
      day: json['day'] ?? '',
      isOpen: json['isOpen'] is bool
          ? json['isOpen'] as bool
          : !(json['isClosed'] is bool && json['isClosed'] as bool),
      slots: parsedSlots,
    );
  }

  static Map<String, dynamic> _timeOfDayToJson(TimeOfDay? time) => {
    'hour': time!.hour,
    'minute': time.minute,
  };

  static TimeOfDay _timeOfDayFromJson(Map<String, dynamic> json) =>
      TimeOfDay(hour: json['hour'] ?? 0, minute: json['minute'] ?? 0);
}

class OpeningTimeSlot {
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;

  const OpeningTimeSlot({required this.openingTime, required this.closingTime});

  Map<String, dynamic> toJson() => {
    'openingTime': OpenHoursModel._timeOfDayToJson(openingTime),
    'closingTime': OpenHoursModel._timeOfDayToJson(closingTime),
  };

  factory OpeningTimeSlot.fromJson(Map<String, dynamic> json) =>
      OpeningTimeSlot(
        openingTime: json['openingTime'] != null
            ? OpenHoursModel._timeOfDayFromJson(json['openingTime'])
            : const TimeOfDay(hour: 9, minute: 0),
        closingTime: json['closingTime'] != null
            ? OpenHoursModel._timeOfDayFromJson(json['closingTime'])
            : const TimeOfDay(hour: 17, minute: 0),
      );

  OpeningTimeSlot copyWith({TimeOfDay? openingTime, TimeOfDay? closingTime}) {
    return OpeningTimeSlot(
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }
}
