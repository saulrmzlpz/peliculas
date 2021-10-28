import 'dart:convert';
import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:peliculas/helpers/app_url.dart';
import 'package:peliculas/helpers/user_preferences.dart';
import 'package:peliculas/models/models.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final _prefs = UserPreferences();
  List<CartItem> cartItems = [];

  String get total {
    return cartItems
        .fold(
            0.0,
            (double currentTotal, CartItem nextProduct) =>
                currentTotal + nextProduct.itemPrice)
        .toStringAsFixed(2);
  }

  bool movieInCart(int movieId) {
    return cartItems.any((cartItem) => cartItem.movieId == movieId);
  }

  int get cartCounter {
    return cartItems.length;
  }

  Future<void> getCartItems() async {
    print('Llamada');

    try {
      final url = Uri.parse(
        "http://${AppUrl.cartItems}/${_prefs.getUser().userId}",
      );
      final response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          final cartItemsResponse = cartItemFromJson(response.body);
          cartItems = cartItemsResponse;
          break;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  addCartItem(Movie movie) async {
    try {
      final url = Uri.parse(
        "http://${AppUrl.cartItems}/new",
      );
      final body = json.encode(CartItem(
          cartItemId: 0,
          userId: _prefs.getUser().userId,
          movieId: movie.id,
          movieName: movie.title,
          itemPrice: movie.popularity,
          itemImg: movie.fullPosterImg,
          itemAddTimeStamp: DateTime.now()));
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      switch (response.statusCode) {
        case 200:
          await getCartItems();
          notifyListeners();
          break;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  deleteCartItem(int cartItemId) async {
    try {
      final url = Uri.parse(
        "http://${AppUrl.cartItems}/$cartItemId",
      );
      final response = await http.delete(url);
      switch (response.statusCode) {
        case 200:
          await getCartItems();
          notifyListeners();
          break;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
