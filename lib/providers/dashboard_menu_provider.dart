import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:movegui_admin_panel/consts/route_constants.dart';

class DashboardMenuState extends ChangeNotifier {
  bool collapsed = false;
  bool darkMode = false;
  String selected = RouteConstants.HOME_ROUTE;
  final Map<String, bool> expandedItems = {};

  void setCollapsed(bool value) {
    collapsed = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }

  void setExpanded(String key, bool value) {
    expandedItems[key] = value;
    notifyListeners();
  }

  void select(String title) {
    selected = title;
    notifyListeners();
  }
}

final dashboardMenuProvider = ChangeNotifierProvider<DashboardMenuState>(
  (ref) => DashboardMenuState(),
);