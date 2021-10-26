// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartItemToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  CartItem({
    required this.cartItemId,
    required this.userId,
    required this.movieId,
    required this.itemPrice,
    required this.itemImg,
    required this.itemAddTimeStamp,
  });

  int cartItemId;
  int userId;
  int movieId;
  int itemPrice;
  String itemImg;
  DateTime itemAddTimeStamp;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItemId: json["cartItemId"],
        userId: json["userId"],
        movieId: json["movieId"],
        itemPrice: json["itemPrice"],
        itemImg: json["itemImg"],
        itemAddTimeStamp: DateTime.parse(json["itemAddTimeStamp"]),
      );

  Map<String, dynamic> toJson() => {
        "cartItemId": cartItemId,
        "userId": userId,
        "movieId": movieId,
        "itemPrice": itemPrice,
        "itemImg": itemImg,
        "itemAddTimeStamp": itemAddTimeStamp.toIso8601String(),
      };
}
