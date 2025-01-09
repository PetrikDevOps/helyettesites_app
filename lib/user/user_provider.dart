import 'package:flutter/material.dart';
import 'package:helyettesites/user/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User.none();
  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = User.none();
    notifyListeners();
  }
}
