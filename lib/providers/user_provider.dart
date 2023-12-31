import 'package:flutter/material.dart';
import 'package:proj1/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    email: '',
    name: '',
    membership: '',
    password: '',
    token: '',
  );
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
