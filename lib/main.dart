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
import './screen/manageproduct.dart';
import './screen/add_item.dart';

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
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: CartIems()),
        ChangeNotifierProxyProvider<Auth, Items>(
          create: (_) => Items(),
          update: (_, auth, oldProducts) => Items(
            uid: auth.uid,
            token: auth.token,
            items: oldProducts?.items ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, oldOrders) => Orders(
            uid: auth.uid,
            token: auth.token,
            orders: oldOrders?.orders,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blueAccent),

        home: Consumer<Auth>(
          builder: (_, auth, child) => FutureBuilder(
            future: auth.getDataFromsPref(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (auth.token == null) {
                  return const AuthScreen();
                } else {
                  return const TapScreen();
                }
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        // AuthScreen(),

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
