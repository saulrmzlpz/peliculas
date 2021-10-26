import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
      userId: 0,
      email: "",
      firstName: "",
      lastName: "",
      token: "",
      renewalToken: "");

  User get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
