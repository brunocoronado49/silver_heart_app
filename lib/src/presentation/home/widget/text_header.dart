import 'package:flutter/material.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0
      ),
      child: Column(
        children: [
          Text(
            'Hola Francisco',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Silver Heart',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            'Joyería',
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
