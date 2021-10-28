import 'package:flutter/material.dart';
import 'package:peliculas/models/cart_item.dart';
import 'package:peliculas/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final int cartCounter = cartProvider.cartCounter;
    return Scaffold(
        appBar: AppBar(
          title: Text('Carrito'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CartItemsList(cartProvider: cartProvider),
              ),
              Text(
                'Articulos: $cartCounter',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Total: \$${cartProvider.total}",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: cartCounter == 0 ? null : () {},
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('Proceder al pago')))
            ],
          ),
        ));
  }
}

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    if (cartProvider.cartItems.isEmpty) {
      return Center(child: Text('Agrega al menos una pelicula al carrito'));
    }
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemCount: cartProvider.cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (direction) => cartProvider
              .deleteCartItem(cartProvider.cartItems[index].cartItemId),
          key: ValueKey<int>(cartProvider.cartItems[index].cartItemId),
          child: CartItemTile(cartItem: cartProvider.cartItems[index]),
        );
      },
    );
  }
}

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        image: NetworkImage(cartItem.itemImg),
        placeholder: AssetImage('assets/no-image.jpg'),
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        cartItem.movieName,
      ),
      trailing: Text("\$${cartItem.itemPrice} MXN"),
    );
  }
}
