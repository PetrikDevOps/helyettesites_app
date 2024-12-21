import 'package:flutter/material.dart';
import 'package:helyettesites/user/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User.guest();  
  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = User.guest();
    notifyListeners();
  }
}
