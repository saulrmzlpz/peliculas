import 'package:flutter/Material.dart';
import 'package:peliculas/helpers/app_url.dart';
import 'package:peliculas/models/models.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  Future<List<CartItem>> getCartItems() async {
    final url = Uri.http(
      AppUrl.baseURL,
      "${AppUrl.cartItems}/1",
    );
    final response = await http.get(url);
    final cartItemsResponse = cartItemFromJson(response.body);
    return cartItemsResponse;
  }
}
