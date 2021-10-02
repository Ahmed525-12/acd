import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/cartdata.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  const CartItemWidget(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of(context);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      onDismissed: (_) =>
          Provider.of<CartIems>(context, listen: false).removecartItem(id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: ListTile(
          title: Text(cartItem.title),
          subtitle: Text('${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.price.round()} X ${cartItem.quantity}')),
    );
  }
}
