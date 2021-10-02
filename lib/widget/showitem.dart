import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/cartdata.dart';
import '../model/itemdata.dart';

import 'package:google_fonts/google_fonts.dart';

class ShowITem extends StatelessWidget {
  const ShowITem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List titlee = Provider.of<Itemdata>(context).spilitString();

    final meal = Provider.of<Itemdata>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(meal.image),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Provider.of<Items>(context, listen: false)
                                  .toggleFav(meal.id);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: meal.isFavorite
                                      ? Colors.redAccent
                                      : Colors.blueAccent,
                                  content: Text(
                                    meal.isFavorite
                                        ? '${meal.title} removed from favorite! '
                                        : '${meal.title} add to favorite!',
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              meal.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.orange,
                            )),
                        Text(
                          titlee[0] + " " + titlee[1],
                          style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                        IconButton(
                            onPressed: () {
                              Provider.of<CartIems>(context, listen: false)
                                  .addCartItem(meal.id, meal.title, meal.price);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.black54,
                                  content: Text('${meal.title} add to cart'),
                                  action: SnackBarAction(
                                      label: 'UNDO',
                                      onPressed: () => Provider.of<CartIems>(
                                              context,
                                              listen: false)
                                          .decreaseQuantity(meal.id)),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.orange,
                            )),
                      ],
                    ),
                    width: 300,
                  )),
              Positioned(
                child: CircleAvatar(
                  radius: 26,
                  child: FittedBox(
                    child: Text(
                      '${meal.price.round()}SAR',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                top: 14,
                right: 14,
              )
            ],
          )
        ],
      ),
    );
  }
}
