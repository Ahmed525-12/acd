import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/authdata.dart';

class DrawrWidget extends StatelessWidget {
  const DrawrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  'Menu',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, 'tabscreen'),
            title: Row(
              children: [
                Icon(Icons.shop),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Shop',
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 0,
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, 'order'),
            title: Row(
              children: [
                Icon(Icons.archive),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'order',
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 0,
          ),
          ListTile(
            onTap: () =>
                Navigator.pushNamed(context, 'ManageProduct.routeName'),
            title: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Manage Orders',
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 0,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/');
              Provider.of<Auth>(context, listen: false).logout();
            },
            title: Row(
              children: [
                Icon(Icons.logout_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
