import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/helpers/user_preferences.dart';
import 'package:peliculas/providers/cart_provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final _prefs = UserPreferences();
  @override
  Widget build(BuildContext context) {
    final _user = _prefs.getUser();
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartItems();
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text(
                'Hola ${_user.firstName} ${_user.lastName}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(_user.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey[400])),
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
            ),
            ListTile(
              leading: Icon(Icons.vpn_key_outlined),
              title: Text("Cerrar sesión"),
              onTap: () => _logout(context, cartProvider),
            )
          ],
        )),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Películas en cines'),
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: Icon(Icons.search_outlined),
            ),
            Badge(
                position: BadgePosition.topEnd(top: 0, end: 10),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(cartProvider.cartCounter.toString()),
                child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('cart'),
                    icon: Icon(Icons.shopping_cart_rounded))),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Tendencias',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }

  void _logout(BuildContext context, CartProvider cartProvider) {
    _prefs.removeUser();
    Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
  }
}
