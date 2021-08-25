import 'package:flutter/material.dart';
import '../model/itemdata.dart';
import '../widget/showitem.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<Items>(context).items;
    return Scaffold(
      body: GridView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: _items[index],
          child: ShowITem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 150,
            childAspectRatio: 4 / 3),
      ),
    );
  }
}
