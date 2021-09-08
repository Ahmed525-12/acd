import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/itemdata.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  bool _isFrist = true;
  Itemdata? itemdata;
  var arg;
  var _titlecontrelar = TextEditingController();
  var _pricecontrelar = TextEditingController();
  var _discreptioncontrelar = TextEditingController();
  var _imgurlcontrelar = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isFrist) {
      arg = ModalRoute.of(context)!.settings.arguments;
      print(arg);
      if (arg != null) {
        itemdata =
            Provider.of<Items>(context, listen: false).findById(arg['id']);
        _titlecontrelar.text = itemdata!.title;
        _pricecontrelar.text = itemdata!.price.toString();
        _discreptioncontrelar.text = itemdata!.description;
        _imgurlcontrelar.text = itemdata!.image;
      }
      _isFrist = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemdata == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _titlecontrelar,
              decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _pricecontrelar,
              decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.price_change)),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _discreptioncontrelar,
              decoration: InputDecoration(
                  labelText: 'Discreption',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _imgurlcontrelar,
              decoration: InputDecoration(
                  labelText: 'Img Url',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  itemdata == null
                      ? Provider.of<Items>(context, listen: false).addItem(
                          _titlecontrelar.text,
                          _discreptioncontrelar.text,
                          double.parse(_pricecontrelar.text),
                          _imgurlcontrelar.text)
                      : Provider.of<Items>(context, listen: false).editItem(
                          arg['id'],
                          _titlecontrelar.text,
                          _discreptioncontrelar.text,
                          _imgurlcontrelar.text,
                          double.parse(_pricecontrelar.text));
                  Navigator.pop(context);
                },
                child: Text(itemdata == null ? 'Add Task' : 'Edit Item'))
          ],
        ),
      ),
    );
  }
}
