import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/itemdata.dart';
import 'package:shoppingcart/screen/cart.dart';
import 'package:shoppingcart/screen/tapscreen.dart';
import './screen/tapscreen.dart';
import './screen/manageproduct.dart';
import './screen/waiting_screen.dart';
import './screen/order.dart';
import './screen/add_items.dart';
import './util/database_ref.dart' as dbref;

void main() async {
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
        home: FutureBuilder(
          future: dbref.openDb(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TapScreen();
            }
            return WaitingScreen();
          },
        ),
        routes: {
          'ManageProduct.routeName': (_) => ManageProduct(),
          'cart': (_) => Cart(),
          'order': (_) => Orders(),
          'addItems': (_) => AddItems(),
        },
      ),
    );
  }
}
