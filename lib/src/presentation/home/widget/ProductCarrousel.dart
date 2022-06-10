import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../data/models/product.dart';
import './item_product.dart';

class ProductCarrousel extends StatelessWidget {
  const ProductCarrousel({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        reverse: false,
        viewportFraction: 0.86,
        height: 230.0,
      ),
      items: this.products.map(
              (product) => ItemProduct(
                product: product, themeDark: products.indexOf(product) == 0
              )
      ).toList()
    );
  }
}