import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart' show ChangeNotifierProvider;
import 'package:movegui_admin_panel/models/user_model.dart';

class CurrentUserProvider extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  void setCurrentUser(UserModel? userModel) {
    _currentUser = userModel;
    notifyListeners();
  }

  
static final currentUserProvider =
    ChangeNotifierProvider<CurrentUserProvider>((ref) {
  return CurrentUserProvider();
});

}