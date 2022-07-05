import 'package:flutter/material.dart';

import 'package:silver_heart/presentation/feed/widgets/feed_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: const [
          HeaderTitle(title: "Productos"),
          ProductsItems(),
          HeaderTitle(title: "Usuarios"),
          UsersItems(),
          HeaderTitle(title: "Otros apartados"),
          OtherApart(),
        ],
      ),
    );
  }
}
