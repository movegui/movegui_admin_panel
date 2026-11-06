
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/establishment/establishment_model.dart';
 



class EstablishmentProvider extends ChangeNotifier {
  EstablishmentModel? _store;

  EstablishmentModel? get store => _store;

  void setStore(EstablishmentModel store) {
    _store = store;
    notifyListeners();
  }

  bool isOpen() {
    if (_store == null) return false;
    final now = DateTime.now();
    final openTime = DateTime(
      now.year,
      now.month,
      now.day,
      _store!.weeklyHours[now.weekday - 1].openTime!.hour,
      _store!.weeklyHours[now.weekday - 1].openTime!.minute,
    );
    final closeTime = DateTime(
      now.year,
      now.month,
      now.day,
      _store!.weeklyHours[now.weekday - 1].closeTime!.hour,
      _store!.weeklyHours[now.weekday - 1].closeTime!.minute,
    );
    return now.isAfter(openTime) && now.isBefore(closeTime);
  }

    void clearStore() {
    _store = null;
    notifyListeners();
  }
}

