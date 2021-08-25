import 'package:flutter/cupertino.dart';

class Itemdata with ChangeNotifier {
  final String id, title, description, image;
  final double price;
  bool isFavorite, cart;

  Itemdata(
      {required this.id,
      required this.price,
      required this.title,
      required this.description,
      required this.image,
      this.isFavorite = false,
      this.cart = false});
}

class Items with ChangeNotifier {
  final List<Itemdata> _items = [
    Itemdata(
        id: '1',
        price: 25,
        title: 'title1',
        description: 'description',
        image: 'https://ahmed525-12.github.io/Construction/img/work1.jpg'),
    Itemdata(
        id: '2',
        price: 40,
        title: 'title2',
        description: 'description2',
        image: 'https://ahmed525-12.github.io/Construction/img/work3.jpeg'),
  ];
  final List<Itemdata> _favoriteMeals = [];
  List<Itemdata> get items => [..._items];
  List<Itemdata> get favoriteMeals => [..._favoriteMeals];
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addItem(
      String id, String title, String description, double price, String image) {
    _items.add(Itemdata(
        id: id,
        price: price,
        title: title,
        description: description,
        image: image));
    notifyListeners();
  }

  void removeFavitem(String id) {
    _favoriteMeals.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addFavItem(String id) {
    _favoriteMeals.add(_items.firstWhere((element) => element.id == id));
    notifyListeners();
  }

  final List<Itemdata> _cart = [];
  List<Itemdata> get cart => [..._cart];
  var cartcount = 0;
  void addCart(String id) {
    _cart.add(_items.firstWhere((element) => element.id == id));
    notifyListeners();
  }

  void removecart(String id) {
    _cart.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}



// solidpernsopal important