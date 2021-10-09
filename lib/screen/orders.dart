import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/orderdata.dart';
import 'package:shoppingcart/screen/waiting_screen.dart';
import 'package:shoppingcart/widget/darwer.dart';
import 'package:shoppingcart/widget/order_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        drawer: DrawrWidget(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).getData(),
          builder: (_, snapshot) {
            List<Order> _orders = Provider.of<Orders>(context).orders;
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                        value: _orders[index],
                        child: OrderWidget(),
                      ),
                      separatorBuilder: (_, i) => Divider(
                        thickness: 1.5,
                        height: 0,
                      ),
                      itemCount: _orders.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                            Text(
                                '${Provider.of<Orders>(context, listen: false).totalPrice}')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return WaitingScreen();
          },
        ));
  }
}
