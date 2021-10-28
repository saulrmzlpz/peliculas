import 'package:flutter/material.dart';
import 'package:peliculas/helpers/user_preferences.dart';
import 'package:peliculas/providers/cart_provider.dart';
import 'package:peliculas/providers/auth_provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPrefs();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: true),
        ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: true),
        ChangeNotifierProvider(create: (_) => CartProvider(), lazy: true),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  final _prefs = UserPreferences();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: _prefs.getUser().userId > 0 ? 'home' : 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
        'cart': (_) => CartScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(color: Colors.indigo, elevation: 0)),
    );
  }
}
