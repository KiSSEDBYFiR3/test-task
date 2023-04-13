import 'package:flutter/material.dart';
import 'package:test_task/feature/domain/entity/products_entity.dart';
import 'package:test_task/feature/presentation/widgets/product_tiles_list.dart';

Widget buildListView(BuildContext context, List<ProductEntity> products) {
  return ListView.builder(
    itemCount: products.length,
    cacheExtent: 1000,
    itemBuilder: (context, index) {
      return productListTile(context: context, product: products[index]);
    },
  );
}
