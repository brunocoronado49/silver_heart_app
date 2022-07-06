import 'package:flutter/material.dart';

class ProfilePostInfo extends StatelessWidget {
  ProfilePostInfo(
      {Key? key,
      required this.name,
      required this.price,
      required this.description,
      required this.seller})
      : super(key: key);

  final String name;
  final String price;
  final String description;
  final String seller;

  late TextStyle style =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 10),
          Text(description, style: style),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Precio(MXN) - $price",
                  style: style,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            heroTag: "delete",
            label: const Text("Eliminar producto"),
            icon: const Icon(Icons.delete_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
