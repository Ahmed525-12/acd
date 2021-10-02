import 'package:flutter/material.dart';
import 'package:shoppingcart/model/itemdata.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/widget/showitem.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Itemdata> _items = Provider.of<Items>(context).favProds;
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (_, i) =>
          ChangeNotifierProvider.value(value: _items[i], child: ShowITem()),
    );
  }
}
