import 'package:peliculas/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  bool saveUser(User user) {
    _prefs.setInt("userId", user.userId);
    _prefs.setString("firstName", user.firstName);
    _prefs.setString("lastName", user.lastName);
    _prefs.setString("email", user.email);
    _prefs.setString("memberSince", user.memberSince);
    return true;
  }

  User getUser() {
    int userId = _prefs.getInt("userId") ?? 0;
    String name = _prefs.getString("firstName") ?? "";
    String lastName = _prefs.getString("lastName") ?? "";
    String email = _prefs.getString("email") ?? "";
    String memberSince = _prefs.getString("token") ?? "";

    return User(
        userId: userId,
        firstName: name,
        email: email,
        lastName: lastName,
        memberSince: memberSince);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");
    prefs.remove("firstName");
    prefs.remove("email");
    prefs.remove("lastName");
    prefs.remove("memberSince");
  }
}
