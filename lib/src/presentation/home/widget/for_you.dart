import 'package:flutter/material.dart';
import '../../../data/models/product.dart';
import './ProductCarrousel.dart';

class ForYou extends StatelessWidget {
  const ForYou({Key? key, required this.products}) : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            "Para ti",
            style: Theme.of(context).textTheme.bodyText1
          ),
        ),
        ProductCarrousel(products: this.products)
      ],
    );
  }
}
