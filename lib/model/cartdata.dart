import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  String title, id;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartIems with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get cartItems => {..._cartItems};
  int get itemscount => _cartItems.length;
  double get totalPrice {
    double total = 0;
    _cartItems.forEach((id, producetvalue) {
      total += producetvalue.price * producetvalue.quantity;
    });
    return total;
  }

  void addCartItem(String id, String title, double price) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(
        id,
        (existitem) => CartItem(
            id: id,
            title: title,
            price: price,
            quantity: existitem.quantity + 1),
      );
    } else {
      _cartItems.addAll(
          {id: CartItem(id: id, title: title, price: price, quantity: 1)});
    }
    notifyListeners();
  }

  void restCart() => _cartItems.clear();

  void decreaseQuantity(String id) {
    if (_cartItems[id]!.quantity == 1) {
      _cartItems.remove(id);
    } else {
      _cartItems.update(
        id,
        (existItem) => CartItem(
          id: id,
          title: existItem.title,
          price: existItem.price,
          quantity: existItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }

  void removecartItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }
}
