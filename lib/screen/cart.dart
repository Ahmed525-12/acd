import 'package:flutter/material.dart';
import 'package:shoppingcart/model/itemdata.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/widget/cartItem.dart';
import 'package:shoppingcart/widget/darwer.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<Items>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      drawer: DrawrWidget(),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, i) =>
            ChangeNotifierProvider.value(value: _items[i], child: CartItem()),
      ),
    );
  }
}
