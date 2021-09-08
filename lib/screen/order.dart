import 'package:flutter/material.dart';
import '../widget/darwer.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: DrawrWidget(),
      body: Center(
        child: Text('Orders'),
      ),
    );
  }
}
