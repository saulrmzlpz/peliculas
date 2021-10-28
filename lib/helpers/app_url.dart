class AppUrl {
  static const String _liveBaseURL = "remote-ur/api/v1";
  static const String _localBaseURL = "192.168.0.160:48238/api";
  static const String movieBaseUrl = 'api.themoviedb.org';
  static const String movieApiKey = 'b285f0eedfa046a18f9806eecdf729fe';
  static const String movieLanguage = 'es-ES';
  static const String baseURL = _localBaseURL;
  static const String login = "$baseURL/Users/authenticate";
  static const String cartItems = "$baseURL/CartItems";
  static const String register = "$baseURL/Users/registration";
}
