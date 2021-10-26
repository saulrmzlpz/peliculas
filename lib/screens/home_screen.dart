import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
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
                badgeContent: Text('0'),
                child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('cart'),
                    icon: Icon(Icons.shopping_cart_rounded)))
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
}
