import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/itemdata.dart';
import 'package:shoppingcart/widget/show_manage_order.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Itemdata> _selectedProd = [];
  List<Itemdata> _prods = [];

  @override
  void didChangeDependencies() {
    _prods = Provider.of<Items>(context).items;
    _selectedProd = [..._prods];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: UnderlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
          ),
          onChanged: (val) {
            setState(
              () {
                _selectedProd = _prods
                    .where(
                      (element) => element.title
                          .toLowerCase()
                          .contains(val.toLowerCase()),
                    )
                    .toList();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _selectedProd.length,
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                  value: _selectedProd[i], child: ShowManageOrder()),
            ),
          ),
        ],
      ),
    );
  }
}
