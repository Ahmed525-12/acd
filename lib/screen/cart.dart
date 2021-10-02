import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/cartdata.dart';
import 'package:shoppingcart/model/orderdata.dart';
import 'package:shoppingcart/widget/cartItem.dart';

import 'package:shoppingcart/widget/darwer.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, CartItem> _cartItem = Provider.of<CartIems>(context).cartItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      drawer: DrawrWidget(),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, i) => const Divider(
                thickness: 1.5,
                height: 0,
              ),
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: _cartItem.values.toList()[i],
                child: CartItemWidget(_cartItem.keys.toList()[i]),
              ),
              itemCount: _cartItem.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total'),
                    Text(
                        '${Provider.of<CartIems>(context, listen: false).totalPrice}')
                  ],
                ),
              ),
            ),
          ),
          MaterialButton(
              color: Colors.blue,
              minWidth: double.infinity,
              height: 50,
              onPressed: () {
                Provider.of<Orders>(context, listen: false).addOrder(
                    _cartItem.values.toList(),
                    Provider.of<CartIems>(context, listen: false).totalPrice);
                Provider.of<CartIems>(context, listen: false).restCart();
                Navigator.pushNamed(context, 'order');
              },
              child: const Text(
                'Order',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
