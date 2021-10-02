import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shoppingcart/model/cartdata.dart';
import 'package:shoppingcart/util/constans.dart';

class Order with ChangeNotifier {
  String id;
  double totalprice;
  List<CartItem> prods;
  DateTime dateTime;
  Order(
      {required this.id,
      required this.totalprice,
      required this.prods,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final String? _uid;
  final String? _token;
  Orders({String? uid, String? token, List<Order>? orders})
      : _uid = uid,
        _token = token,
        _orders = orders ?? [];
  List<Order> _orders = [];
  List<Order> get orders => [..._orders];

  double get totalprice {
    double total = 0;
    for (var element in _orders) {
      total += element.totalprice;
    }
    return total;
  }

  Future<void> getData() async {
    String uri = '$url/orders.json';
    var response = await get(Uri.parse(uri));
    Map<String, dynamic>? extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    print(extractedData);
    _orders.clear();
    extractedData.forEach((id, data) {
      _orders.add(
        Order(
          id: id,
          totalprice: data['totalprice'],
          prods: (data['prods'] as List<dynamic>)
              .map(
                (prod) => CartItem(
                  id: prod['id'],
                  title: prod['title'],
                  price: double.parse(prod['price']),
                  quantity: prod['quantity'],
                ),
              )
              .toList(),
          dateTime: DateTime.parse(
            data['date'],
          ),
        ),
      );
    });
  }

  Future<void> addOrder(List<CartItem> prods, double totalprice) async {
    if (prods.isEmpty) {
      return;
    }
    String uri = '$url/orders.json';
    var response = await post(
      Uri.parse(uri),
      body: json.encode(
        {
          'totalprice': totalprice,
          'date': DateTime.now().toIso8601String(),
          // Convert CartItem to Map
          'prods': prods
              .map(
                (prod) => {
                  'id': prod.id,
                  'title': prod.title,
                  'price': prod.price.toString(),
                  'quantity': prod.quantity,
                },
              )
              .toList(),
        },
      ),
    );
    _orders.add(
      Order(
        id: json.decode(response.body)['name'],
        totalprice: totalprice,
        prods: prods,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
