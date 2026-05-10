import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class AppbarTitleProvider with ChangeNotifier {
  String _title = "";

  String get title => _title;

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  
static final appbarTitleProvider =
    ChangeNotifierProvider<AppbarTitleProvider>((ref) {
  return AppbarTitleProvider();
});

}
