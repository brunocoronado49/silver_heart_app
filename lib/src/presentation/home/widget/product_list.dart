import 'package:flutter/material.dart';
import '../../../data/models/product.dart';
import './compact_item_product.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: this.products.length,
      itemBuilder: (context, index) => CompactItemProduct(product: this.products[index]),
    );
  }
}
