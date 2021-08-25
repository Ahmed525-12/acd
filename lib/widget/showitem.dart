import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/itemdata.dart';

import 'package:google_fonts/google_fonts.dart';

class ShowITem extends StatelessWidget {
  const ShowITem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (Provider.of<Itemdata>(context, listen: false)
                                  .isFavorite) {
                                Provider.of<Itemdata>(context, listen: false)
                                    .isFavorite = false;

                                Provider.of<Items>(context, listen: false)
                                    .removeFavitem(meal.id);
                              } else {
                                Provider.of<Itemdata>(context, listen: false)
                                    .isFavorite = true;

                                Provider.of<Items>(context, listen: false)
                                    .addFavItem(meal.id);
                              }
                            },
                            icon: Icon(
                              meal.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.orange,
                            )),
                        Text(
                          meal.title,
                          style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                        IconButton(
                            onPressed: () {
                              if (Provider.of<Itemdata>(context, listen: false)
                                  .cart) {
                                Provider.of<Itemdata>(context, listen: false)
                                    .cart = false;

                                Provider.of<Items>(context, listen: false)
                                    .removecart(meal.id);
                              } else {
                                Provider.of<Itemdata>(context, listen: false)
                                    .cart = true;

                                Provider.of<Items>(context, listen: false)
                                    .addCart(meal.id);
                              }
                              for (var i = 0;
                                  i < Provider.of<Items>(context).cartcount;
                                  i++) {
                                Provider.of<Items>(context).cartcount++;
                              }
                            },
                            icon: Icon(
                              meal.cart
                                  ? Icons.shopping_cart
                                  : Icons.shopping_cart_outlined,
                              color: Colors.orange,
                            )),
                      ],
                    ),
                    width: 300,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
