import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';
import 'package:test_task/feature/presentation/widgets/product_tiles_grid.dart';

Widget buildGridView(BuildContext context, List<ProductEntity> products) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: GridView.builder(
        itemCount: products.length,
        cacheExtent: 1000,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 185 / 260,
          mainAxisSpacing: 25,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return productGridTile(context: context, product: products[index]);
        }),
  );
}
