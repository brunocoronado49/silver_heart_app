import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePostInfo extends StatefulWidget {
  const ProfilePostInfo(
      {Key? key,
      required this.name,
      required this.price,
      required this.description,
      required this.seller,
      required this.ref
    }) : super(key: key);

  final String name;
  final String price;
  final String description;
  final String seller;
  final String ref;

  @override
  State<ProfilePostInfo> createState() => _ProfilePostInfoState();
}

class _ProfilePostInfoState extends State<ProfilePostInfo> {
  late TextStyle style =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);

  @override
  Widget build(BuildContext context) {
     
    Future<void> _delete(String ref) async {
      await FirebaseStorage.instance.ref(ref).delete();
      setState(() {});
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 10),
          Text(widget.description, style: style),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Precio(MXN) - ${widget.price}",
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
            onPressed: () {
              _delete(widget.ref);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
