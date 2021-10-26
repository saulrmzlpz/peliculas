import 'dart:async';

import 'package:peliculas/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId);
    prefs.setString("firstName", user.firstName);
    prefs.setString("lastName", user.lastName);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);
    prefs.setString("renewalToken", user.renewalToken);
    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId") ?? 0;
    String name = prefs.getString("firstName") ?? "";
    String lastName = prefs.getString("lastName") ?? "";
    String email = prefs.getString("email") ?? "";
    String token = prefs.getString("token") ?? "";
    String renewalToken = prefs.getString("renewalToken") ?? "";

    return User(
        userId: userId,
        firstName: name,
        email: email,
        lastName: lastName,
        token: token,
        renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("firstName");
    prefs.remove("email");
    prefs.remove("lastName");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
}
