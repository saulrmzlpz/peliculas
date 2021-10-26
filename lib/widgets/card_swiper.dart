import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return movies.isEmpty
        ? Container(
            width: double.infinity,
            height: size.height * 0.5,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            width: double.infinity,
            height: size.height * 0.5,
            child: Swiper(
              itemCount: movies.length,
              layout: SwiperLayout.STACK,
              itemWidth: size.width * 0.6,
              itemHeight: size.height * 0.4,
              itemBuilder: (_, int index) {
                movies[index].heroId = 'swiper - ${movies[index].id}';
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'details',
                      arguments: movies[index]),
                  child: Hero(
                    tag: movies[index].heroId!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(movies[index].fullPosterImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
