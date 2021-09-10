import 'package:flutter/cupertino.dart';
import 'package:shoppingcart/util/database_ref.dart';

class Itemdata with ChangeNotifier {
  final String title, description, image;
  final double price;
  final int id;
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
  final List<Itemdata> _items = [];
  List<Itemdata> get items => [..._items];
///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
  Future<void> getData() async {
    List<Map<String, dynamic>> data =
        await database_ref!.rawQuery('select * from items ');

    _items.clear();
    print("gggggggggggggggggggggggggggggggggggg $data");
    data.forEach((element) {
      print("gggggggggggggggggggggggggggggggggggg $element");
      _items.add(Itemdata(
          id: element['id'],
          price: double.parse("${element['price']}"),
          title: element['title'],
          description: element['description'],
          image: element['image']));
    });
  }

///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
  Future<void> removeItem(int id) async {
    await database_ref!.rawDelete('DELETE FROM items WHERE id = $id');
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> addItem(
    String title,
    String description,
    double price,
    String image,
  ) async {
    int? id;
    await database_ref!.transaction((txn) async {
      id = await txn.rawInsert(
          'INSERT INTO items(title,description,image,price) VALUES("$title","$description","$image","$price")');
      print(id);
    });

    notifyListeners();
  }

  ///// eidt item
  Itemdata findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> editItem(int id, String title, String description, String image,
      double price) async {
    await database_ref!.rawUpdate(
        'UPDATE items SET title = "$title",description="$description",image="$image",price="$price" WHERE id = $id');
    // _items.add(Itemdata(
    //     id: id,
    //     price: price,
    //     title: title,
    //     description: description,
    //     image: image));
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// FAV/////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  final List<Itemdata> _favoriteMeals = [];
  List<Itemdata> get favoriteMeals => [..._favoriteMeals];
  void removeFavitem(int id) {
    _favoriteMeals.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addFavItem(int id) {
    _favoriteMeals.add(_items.firstWhere((element) => element.id == id));
    notifyListeners();
  }
//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// cart/////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

  final List<Itemdata> _cart = [];
  List<Itemdata> get cart => [..._cart];
  var cartcount = 0;
  void addCart(int id) {
    _cart.add(_items.firstWhere((element) => element.id == id));
    notifyListeners();
  }

  void removecart(int id) {
    _cart.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

// solidpernsopal important
