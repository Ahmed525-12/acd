import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/itemdata.dart';

class ShowManageOrder extends StatefulWidget {
  const ShowManageOrder({Key? key}) : super(key: key);

  @override
  _ShowManageOrderState createState() => _ShowManageOrderState();
}

class _ShowManageOrderState extends State<ShowManageOrder> {
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, 'addItems',
                    arguments: {'id': meal.id}),
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () => Provider.of<Items>(context, listen: false)
                    .removeItem(meal.id),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
