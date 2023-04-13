import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';

Widget productGridTile(
    {required BuildContext context, required ProductEntity product}) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Theme.of(context).cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    elevation: 12,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 185,
            height: 150,
            child: Image.network(
              product.image,
              fit: BoxFit.fill,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.red, size: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(product.rating.toString(),
                    style: const TextStyle(fontFamily: "Lexend", fontSize: 15)),
              ),
              Expanded(
                child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: "Lexend", fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              "${product.price} \$",
              style: const TextStyle(
                  fontFamily: "Lexend",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart_checkout_rounded,
                  size: 35,
                ),
                onPressed: () {},
              ),
            ))
          ],
        )
      ],
    ),
  );
}
