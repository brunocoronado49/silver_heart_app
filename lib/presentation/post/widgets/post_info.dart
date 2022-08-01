import 'package:flutter/material.dart';
import 'package:silver_heart/theme/app_theme.dart';

// ignore: must_be_immutable
class PostInfo extends StatelessWidget {
  PostInfo(
      {Key? key,
      required this.name,
      required this.price,
      required this.description,
      required this.seller, required this.banc, required this.accountNumber})
      : super(key: key);

  final String name;
  final String price;
  final String description;
  final String seller;
  final String banc;
  final String accountNumber;

  late TextStyle style =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);
  
  void displayBancInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Paga el producto por medio de transferencia!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("El banco que usa el vendedor es: $banc"),
              const SizedBox(height: 20),
              Text("No. de cuenta a depositar: $accountNumber")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description, style: style),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Vendedor: $seller",
                    style: style,
                  ),
                  Text(
                    "Precio(MXN): $price",
                    style: style,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.thirdColor,
        heroTag: "buy",
        label: const Text("Comprar"),
        icon: const Icon(Icons.shop_outlined),
        onPressed: () {},
      ),
    );
  }
}
