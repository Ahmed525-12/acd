import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/itemdata.dart';
import './home_screen.dart';
import './favorite.dart';
import '../widget/darwer.dart';

class TapScreen extends StatefulWidget {
  const TapScreen({Key? key}) : super(key: key);

  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  int _currentIndex = 0;
  late List<Map<String, dynamic>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'title': 'HomePage',
        'page': Homescreen(),
      },
      {
        'title': 'favorite',
        'page': FavoriteScreen(),
      }
    ];
    super.initState();
  }

  void _changeindex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'cart'),
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
        ],
      ),
      drawer: DrawrWidget(),
      body: FutureBuilder(
        future: Provider.of<Items>(context).getData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _pages[_currentIndex]['page'];
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeindex,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}
