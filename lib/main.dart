import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/itemdata.dart';
import 'package:shoppingcart/screen/cart.dart';
import 'package:shoppingcart/screen/tapscreen.dart';
import './screen/tapscreen.dart';
import './screen/manageproduct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Items(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blueAccent),
        routes: {
          '/': (_) => TapScreen(),
          'ManageProduct.routeName': (_) => ManageProduct(),
          'cart': (_) => Cart(),
        },
      ),
    );
  }
}
