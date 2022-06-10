import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              iconSize: 40.0,
              onPressed: () {},
              icon: Icon(Icons.menu_outlined)
          ),
          Row(
            children: [
              IconButton(
                  iconSize: 40.0,
                  onPressed: () {},
                  icon: Icon(Icons.search)
              ),
              IconButton(
                  iconSize: 40.0,
                  onPressed: () {},
                  icon: Icon(Icons.settings)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
