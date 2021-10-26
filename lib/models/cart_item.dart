// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

class CartItem {
  CartItem({
    required this.cartItemId,
    required this.userId,
    required this.movieId,
    required this.movieName,
    required this.itemPrice,
    required this.itemImg,
    required this.itemAddTimeStamp,
  });

  int cartItemId;
  int userId;
  int movieId;
  String movieName;
  double itemPrice;
  String itemImg;
  DateTime itemAddTimeStamp;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItemId: json["CartItemId"],
        userId: json["UserId"],
        movieId: json["MovieId"],
        movieName: json["MovieName"],
        itemPrice: json["ItemPrice"],
        itemImg: json["ItemImg"],
        itemAddTimeStamp: DateTime.parse(json["ItemAddTimeStamp"]),
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "MovieId": movieId,
        "MovieName": movieName,
        "ItemPrice": itemPrice,
        "ItemImg": itemImg,
      };
}
