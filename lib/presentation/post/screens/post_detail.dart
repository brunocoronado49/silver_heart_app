import 'package:flutter/material.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/theme/app_theme.dart';

class PostDetail extends StatelessWidget {
  const PostDetail(
      {Key? key,
      required this.name,
      required this.description,
      required this.price,
      required this.seller,
      required this.imageUrl,
      required this.type,
      required this.uid,
      required this.banc,
      required this.accountNumber})
      : super(key: key);

  final String name;
  final String description;
  final String price;
  final String seller;
  final String imageUrl;
  final String type;
  final String uid;
  final String banc;
  final String accountNumber;

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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            PostImage(imageUrl: imageUrl, uid: uid, type: type),
            const SizedBox(height: 20),
            PostInfo(
              name: name,
              price: price,
              description: description,
              seller: seller,
              banc: banc,
              accountNumber: accountNumber,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.shop_2_outlined),
        label: const Text("Comprar"),
        onPressed: () => displayBancInfo(context),
        backgroundColor: AppTheme.thirdColor,
        elevation: 0,
      ),
    );
  }
}
