import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/app_url.dart';
import 'package:peliculas/helpers/user_preferences.dart';
import 'package:peliculas/models/models.dart';

enum AuthStatus {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  AuthStatus _loggedInStatus = AuthStatus.NotLoggedIn;
  AuthStatus _registeredInStatus = AuthStatus.NotRegistered;

  AuthStatus get loggedInStatus => _loggedInStatus;
  AuthStatus get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;

    _loggedInStatus = AuthStatus.Authenticating;
    notifyListeners();
    try {
      final url = Uri.parse(
        "http://${AppUrl.login}",
      );
      http.Response response = await http.post(
        url,
        body: json.encode(
            {'AuthEmail': email.trim(), 'AuthPassword': password.trim()}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        var userData = responseData;
        User authUser = User.fromJson(userData);
        UserPreferences().saveUser(authUser);
        _loggedInStatus = AuthStatus.LoggedIn;
        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else if (response.statusCode == 500) {
        _loggedInStatus = AuthStatus.NotLoggedIn;
        throw ('Server error');
      } else {
        _loggedInStatus = AuthStatus.NotLoggedIn;
        result = {
          'status': false,
          'message': 'No se pudo iniciar sesión. Revise sus credenciales.'
        };
      }
    } catch (e) {
      _loggedInStatus = AuthStatus.NotLoggedIn;

      result = {
        'status': false,
        'message': 'No se pudo conectar al servidor. Intente mas tarde.'
      };
    }
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> registerNewUser(
      String name, String lastName, String email, String password) async {
    Map<String, dynamic> result;
    _registeredInStatus = AuthStatus.Registering;
    notifyListeners();
    try {
      final url = Uri.parse("http://${AppUrl.register}");
      http.Response response = await http.post(url,
          body: json.encode({
            'FirstName': name.trim(),
            'LastName': lastName.trim(),
            'UserEmail': email.trim(),
            'UserPassword': password.trim(),
          }),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        result = {
          'status': true,
          'message': 'Registro exitoso',
        };
        _registeredInStatus = AuthStatus.Registered;
      } else {
        result = {
          'status': false,
          'message': 'No se pudo registrar',
        };
        _registeredInStatus = AuthStatus.NotRegistered;
      }
    } catch (e) {
      _registeredInStatus = AuthStatus.NotRegistered;
      result = {
        'status': false,
        'message': 'No se pudo conectar al servidor. Intente mas tarde.',
      };
    }

    notifyListeners();
    return result;
  }
}
