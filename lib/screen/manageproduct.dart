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
    final items = Provider.of<Items>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('manage Product'),
      ),
      drawer: DrawrWidget(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: items[index],
          child: ShowManageOrder(),
        ),
      ),
    );
  }
}
