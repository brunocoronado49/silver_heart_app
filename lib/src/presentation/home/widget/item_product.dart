import 'package:flutter/material.dart';
import '../../../data/models/product.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({
    Key? key,
    required this.product,
    this.themeDark = false
  }) : super(key: key);

  final bool themeDark;
  final Product product;

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 15.0,
          bottom: 20.0,
          top: 20.0
      ),
      child: Container(
        decoration: _boxDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _userLogo(),
                  _favIcon(),
                ],
              ),
              _infoProductText(context)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration? _boxDecoration(context) {
    return BoxDecoration(
      color:
        Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
            color: Colors.black45,
            offset: Offset(4.0, 4.0),
            blurRadius: 10.0
        ),
      ],
    );
  }

  Widget _userLogo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          "https://cdn.shopify.com/s/files/1/0259/2745/0705/products/PIC-BT-WR-207_1_034f0614-8506-4e20-98b3-e1d8acca5cb5_1440x.jpg?v=1624282002",
          width: 60.0,
        ),
      ),
    );
  }

  Widget _favIcon() {
    return GestureDetector(
      child: Icon(
        this.widget.product.favorite ? Icons.favorite : Icons.favorite_border,
        color: this.widget.themeDark ? Colors.red : Colors.red,
      ),
      onTap: () {
        setState(() {
          this.widget.product.favorite = !this.widget.product.favorite;
        });
      },
    );
  }

  Widget _infoProductText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.widget.product.name.toString(),
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
          ),
        ),
        Text(
          this.widget.product.type.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          this.widget.product.price.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 3.0)
      ],
    );
  }
}