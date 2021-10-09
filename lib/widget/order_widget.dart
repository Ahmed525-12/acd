import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/orderdata.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    Order _order = Provider.of<Order>(context);
    return ExpansionTile(
      title: Text('${_order.totalPrice}'),
      subtitle: Text(DateFormat.yMMMd().format(_order.date)),
      children: _order.prods
          .map((e) => ListTile(
                title: Text(e.title),
                trailing: Text('${e.price} X ${e.quantity}'),
              ))
          .toList(),
    );
  }
}
