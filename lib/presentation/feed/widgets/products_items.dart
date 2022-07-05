import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:silver_heart/core/helpers/carousel_options.dart';
import 'package:silver_heart/presentation/feed/widgets/feed_widgets.dart';
import 'package:silver_heart/presentation/post/screens/post_detail.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProductsItems extends StatefulWidget {
  const ProductsItems({Key? key}) : super(key: key);

  @override
  State<ProductsItems> createState() => _ProductsItemsState();
}

class _ProductsItemsState extends State<ProductsItems> {
  final Stream<QuerySnapshot> _postStream =
    FirebaseFirestore.instance.collection("post").snapshots();
      
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder(
        stream: _postStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return CarouselSlider(
            options: Carousel.options,
            items: snapshot.data?.docs.map((DocumentSnapshot document){
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return Builder(
                builder: (BuildContext builder) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: AppTheme.backgroundColor,
                    child: ListTilePost(
                      title: data["name"],
                      seller: data["seller"],
                      price: data["price"],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => 
                              PostDetail(
                                name: data["name"],
                                description: data["description"],
                                seller: data["seller"],
                                price: data["price"],
                              )
                          )
                        );
                      },
                    ),
                  );
                }
              );
            }).toList() ?? [],
          );
        },
      ),
    );
  }
}