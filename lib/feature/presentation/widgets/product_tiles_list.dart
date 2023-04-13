import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';

Widget productListTile(
    {required BuildContext context, required ProductEntity product}) {
  return SizedBox(
    height: 175,
    width: 270,
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 190,
              height: 170,
              child: Image.network(
                product.image,
                fit: BoxFit.fill,
              )),
          SizedBox(
            height: 170,
            width: 190,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 5),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "Lexend", fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Icon(Icons.star_rounded,
                              color: Colors.red, size: 30),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(product.rating.toString(),
                              style: const TextStyle(
                                  fontFamily: "Lexend", fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 10, right: 10),
                          child: Text(
                            "${product.price} \$",
                            style: const TextStyle(
                                fontFamily: "Lexend",
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                            child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.shopping_cart_checkout_rounded,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
