import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../../../data/structure/items.dart' as Items;
import '../widget/custom_app_bar.dart';
import '../widget/text_header.dart';
import '../widget/ProductCarrousel.dart';
import '../widget/product_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const CustomAppBar(),
            const TextHeader(),
            _forYou(context),
            _recent(context),
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
              //onTap: () {
               // function for go to the feed
               // Navigator.pop(context);
             // },
            ),
            ListTile(
              title: Text('Item 2'),
              //onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
               // Navigator.pop(context);
              //},
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
        //Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //child: ProductList(products: Items.recentsProducts),
        ),
      ],
    );
  }
}