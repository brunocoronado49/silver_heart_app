import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';

class Carousel {
  static CarouselOptions options = CarouselOptions(
    height: 250,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 3),
    autoPlayAnimationDuration: const Duration(milliseconds: 500),
    autoPlayCurve: Curves.fastOutSlowIn,
  );
}