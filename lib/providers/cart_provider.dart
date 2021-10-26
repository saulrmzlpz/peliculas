import 'dart:convert';
import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:peliculas/helpers/app_url.dart';
import 'package:peliculas/models/models.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  CartProvider() {
    getCartItems();
  }
  List<CartItem> cartItems = [];
  getCartItems() async {
    try {
      final url = Uri.parse(
        "http://${AppUrl.cartItems}/1",
      );
      final response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          final cartItemsResponse = cartItemFromJson(response.body);
          cartItems = cartItemsResponse;
          notifyListeners();
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
          userId: 1,
          movieId: movie.id,
          movieName: movie.title,
          itemPrice: movie.popularity,
          itemImg: movie.fullPosterImg,
          itemAddTimeStamp: DateTime.now()));
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      switch (response.statusCode) {
        case 200:
          return true;
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
          return true;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
