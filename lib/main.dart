import 'package:flutter/material.dart';
import 'package:peliculas/providers/login_provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        //'login': (_) => LoginScreen(),
        //'register': (_) => HomeScreen(),
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
        'cart': (_) => CartScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(color: Colors.indigo, elevation: 0)),
    );
  }
}
