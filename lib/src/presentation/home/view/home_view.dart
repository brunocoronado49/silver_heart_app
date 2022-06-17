import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/custom_app_bar.dart';
import '../widget/text_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(),
            TextHeader(),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Text(
                "Silver heart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            ListTile(
              title: Text("Inicio"),
            ),
            ListTile(
              title: Text('Item 2'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forYou(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            'Para ti',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        //ProductCarrousel(products: Items.productsForYou),
      ],
    );
  }

  Widget _recent(context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 5.0,
              bottom: 15.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Recientes',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Ver todo',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}