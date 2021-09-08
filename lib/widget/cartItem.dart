import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/itemdata.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final meal = Provider.of<Itemdata>(context);

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(meal.image),
          ),
          title: Text(meal.title),
          subtitle: Text('${meal.price}'),
          trailing: IconButton(
            onPressed: () =>
                Provider.of<Items>(context, listen: false).removecart(meal.id),
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
