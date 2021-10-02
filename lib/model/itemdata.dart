import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shoppingcart/util/constans.dart';

class Itemdata with ChangeNotifier {
  String title, description, image, id;
  double price;

  bool isFavorite;

  Itemdata({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.image,
    this.isFavorite = false,
  });
  List spilitString() {
    return title.split(' ');
  }

  Future<void> toggleFav() async {
    String uri = '$url/products/$id.json';
    await patch(
      Uri.parse(uri),
      body: json.encode({
        'isFavorite': !isFavorite,
      }),
    );
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Items with ChangeNotifier {
  final String? _uid;
  final String? _token;

  Items({
    String? uid,
    String? token,
    List<Itemdata>? items,
  })  : _uid = uid,
        _token = token,
        _items = items ?? [];

  List<Itemdata> _items = [];
  List<Itemdata> get items => [..._items];

///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
  Future<void> getData() async {
    String uri = '$url/products.json?auth=$_token';
    var response = await get(Uri.parse(uri));
    Map<String, dynamic>? extractedData = json.decode(response.body);
    if (extractedData == null) {
      return null;
    }
    _items.clear();
    extractedData.forEach(
      (id, data) {
        _items.add(
          Itemdata(
            id: id,
            title: data['title'],
            description: data['description'],
            image: data['image'],
            price: double.parse(data['price']),
            isFavorite: data['isFavorite'],
          ),
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
  Future<void> removeItem(String id) async {
    String uri = '$url/products/$id.json?auth=$_token';
    await delete(Uri.parse(uri));

    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> addItem(
    String title,
    String description,
    double price,
    String image,
  ) async {
    String uri = '$url/products.json?auth=$_token';
//post requset api
    var response = await post(
      Uri.parse(uri),
      body: json.encode({
        'title': title,
        'description': description,
        'price': price.toString(),
        'image': image,
        'isFavorite': false
      }),
    );

    _items.add(
      Itemdata(
          id: json.decode(response.body)['name'],
          price: price,
          title: title,
          description: description,
          image: image,
          isFavorite: false),
    );

    notifyListeners();
  }

  ///// eidt item
  Itemdata findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> editItem(String id, String title, String description,
      String image, double price) async {
    String uri = '$url/products/$id.json?auth=$_token';
    await put(
      Uri.parse(uri),
      body: json.encode({
        'title': title,
        'description': description,
        'price': price.toString(),
        'image': image,
        'isFavorite': false
      }),
    );

    int updatedindex = _items.indexWhere((element) => element.id == id);
    _items[updatedindex].title = title;
    _items[updatedindex].price = price;
    _items[updatedindex].description = description;
    _items[updatedindex].image = image;
    _items[updatedindex].isFavorite = false;

    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// FAV/////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  List<Itemdata> get favProds =>
      _items.where((element) => element.isFavorite).toList();

  Future<void> toggleFav(String id) async {
    await _items.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }
//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// cart/////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

}
