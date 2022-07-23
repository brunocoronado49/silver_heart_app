import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/feed/widgets/feed_widgets.dart';
import 'package:silver_heart/presentation/post/screens/post_detail.dart';
import 'package:silver_heart/presentation/profile/screens/profile_post_detail_screen.dart';
import 'package:silver_heart/theme/app_theme.dart';

class PostsItems extends StatefulWidget {
  const PostsItems({Key? key, required this.user}) : super(key: key);

  final MyUser user;

  @override
  State<PostsItems> createState() => _PostsItemsState();
}

class _PostsItemsState extends State<PostsItems> {
  List<Map<String, dynamic>> files = [];

  // Function to get posts
  Future<List<Map<String, dynamic>>> _loadPosts() async {
    final result = await FirebaseStorage.instance.ref().child("/posts/").listAll();
    final allFiles = result.items;

    try {
      await Future.forEach<Reference>(allFiles, (file) async {
        final String fileUrl = await file.getDownloadURL();
        final FullMetadata fileMeta = await file.getMetadata();

        files.add({
          "url": fileUrl,
          "path": file.fullPath,
          "seller": fileMeta.customMetadata?['seller'] ?? 'nobody',
          "description":
              fileMeta.customMetadata?['description'] ?? 'no description',
          "name": fileMeta.customMetadata?["name"] ?? "no name",
          "price": fileMeta.customMetadata?["price"] ?? "no price",
          "type": fileMeta.customMetadata?["type"] ?? "no type",
        });
      });
    } catch (error) {
      throw Exception(error.toString());
    }

    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
        future: _loadPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final Map<String, dynamic> post = snapshot.data![index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: AppTheme.backgroundColor,
                  child: Column(
                    children: [
                      FadeInImage(
                        image: NetworkImage(post['url']),
                        placeholder: const AssetImage("assets/loading.gif"),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 300),
                      ),
                      ListTilePost(
                        title: post["name"],
                        seller: post["seller"],
                        price: post["price"],
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            if (post["seller"] != widget.user.name) {
                              return PostDetail(
                                name: post["name"],
                                description: post["description"],
                                seller: post["seller"],
                                price: post["price"],
                                imageUrl: post["url"],
                              );
                            }
                            return ProfilePostDetailScreen(
                              name: post["name"],
                              description: post["description"],
                              seller: post["seller"],
                              price: post["price"],
                              imageUrl: post["url"],
                            );
                          }));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        },
      ),
    );
  }
}
