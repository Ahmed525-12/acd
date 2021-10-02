import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/authdata.dart';
import 'package:shoppingcart/model/cartdata.dart';
import 'package:shoppingcart/model/itemdata.dart';
import 'package:shoppingcart/model/orderdata.dart';
import 'package:shoppingcart/screen/auth_screen.dart';
import 'package:shoppingcart/screen/cart.dart';
import 'package:shoppingcart/screen/orders.dart';
import 'package:shoppingcart/screen/search_screen.dart';
import 'package:shoppingcart/screen/tapscreen.dart';
import './screen/tapscreen.dart';
import './screen/manageproduct.dart';
import 'screen/add_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartIems(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, orders) => Orders(
              uid: auth.uid, token: auth.token, orders: orders?.orders ?? []),
        ),
        ChangeNotifierProxyProvider<Auth, Items>(
          create: (_) => Items(),
          update: (_, auth, items) => Items(
            uid: auth.uid,
            token: auth.token,
            items: items?.items ?? [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home: AuthScreen(),
        routes: {
          'tabscreen': (_) => TapScreen(),
          'ManageProduct.routeName': (_) => ManageProduct(),
          'cart': (_) => Cart(),
          'additem': (_) => AddItem(),
          'order': (_) => OrderScreen(),
          'search': (_) => SearchScreen(),
        },
      ),
    );
  }
}
