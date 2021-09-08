// ManageProduct

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/itemdata.dart';
import '../widget/show_manage_order.dart';
import '../widget/darwer.dart';

class ManageProduct extends StatelessWidget {
  static const routeName = 'ManageProduct';

  const ManageProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'addItems'),
              icon: Icon(Icons.add_circle))
        ],
      ),
      drawer: DrawrWidget(),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, i) => ChangeNotifierProvider.value(
            value: _items[i], child: ShowManageOrder()),
      ),
    );
  }
}
