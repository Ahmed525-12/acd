import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/itemdata.dart';

class ShowManageOrder extends StatelessWidget {
  const ShowManageOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meal = Provider.of<Itemdata>(context);

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(meal.image),
          ),
          title: Text(meal.title),
          trailing: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Provider.of<Items>(context, listen: false)
                        .removeItem(meal.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
