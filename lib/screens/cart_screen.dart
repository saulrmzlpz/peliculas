import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: ListView(
        children: const [
          ListTile(
              title: Text(
            "Película 1",
          )),
          ListTile(
              title: Text(
            "Película 2",
          )),
          ListTile(
              title: Text(
            "Película 3",
          )),
          ListTile(
              title: Text(
            "Película 4",
          )),
        ],
      ),
    );
  }
}
