import 'package:flutter/material.dart';
import 'package:shoppingcart/screen/waiting_screen.dart';
import '../model/itemdata.dart';
import '../widget/showitem.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Items>(context, listen: false).getData(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final _items = Provider.of<Items>(context).items;

          return ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: _items[index],
              child: ShowITem(),
            ),
          );
        }
        return WaitingScreen();
      },
    );
  }
}
