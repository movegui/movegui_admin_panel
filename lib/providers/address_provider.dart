
import 'package:flutter/material.dart';
import 'package:movegui_admin_panel/models/adress_model.dart';



class AddressProvider extends ChangeNotifier {
  AdressModel? _address;

  AdressModel? get address => _address;

  void setAddress(AdressModel address) {
    _address = address;
    notifyListeners();
  }

  void clearAdress() {
    _address = null;
    notifyListeners();
  }

}