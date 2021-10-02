import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/itemdata.dart';
import '../widget/darwer.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  Itemdata itemdata =
      Itemdata(id: '', price: 0.0, title: '', description: '', image: '');
  bool _isFrist = true;
  Map<String, dynamic>? _args;
  GlobalKey<FormState> _globalKey = GlobalKey();
  void onSave() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _globalKey.currentState!.save();
    if (_args != null) {
      Provider.of<Items>(context, listen: false).editItem(_args!['id'],
          itemdata.title, itemdata.description, itemdata.image, itemdata.price);
      Navigator.pop(context);
    } else {
      Provider.of<Items>(context, listen: false).addItem(
        itemdata.title,
        itemdata.description,
        itemdata.price,
        itemdata.image,
      );
      Navigator.pop(context);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isFrist) {
      _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (_args != null) {
        Itemdata _updateItem =
            Provider.of<Items>(context, listen: false).findById(_args!['id']);
        itemdata = _updateItem;
      }
      _isFrist = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_args == null ? 'Add Item' : 'Edit Item'),
      ),
      drawer: DrawrWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: itemdata.title,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title)),
                onSaved: (newValue) {
                  itemdata.title = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pelease write the title';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: itemdata.price.toString(),
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.price_change),
                ),
                keyboardType: TextInputType.number,
                onSaved: (newValue) {
                  itemdata.price = double.parse(newValue!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pelease write the price';
                  } else if (double.parse(value) <= 0) {
                    return 'enter valid price ';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: itemdata.description,
                decoration: InputDecoration(
                  labelText: 'Discreption',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (newValue) {
                  itemdata.description = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pelease write the description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: itemdata.image,
                decoration: InputDecoration(
                  labelText: 'Img Url',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                onSaved: (newValue) {
                  itemdata.image = newValue!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'pelease write the URL';
                  } else if (!value.startsWith('http')) {
                    return 'Enter valid URL';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text(_args == null ? 'Add Item' : 'Edit Item'),
                onPressed: onSave,
              )
            ],
          ),
        ),
      ),
    );
  }
}
