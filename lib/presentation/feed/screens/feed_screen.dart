import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/presentation/feed/widgets/feed_widgets.dart';
import 'package:silver_heart/presentation/feed/widgets/posts_items.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserStateReady) {
          return SafeArea(
            child: ListView(
              children: [
                const FeedHeader(),
                const HeaderTitle(title: "Usuarios"),
                UsersItems(user: state.user),
                const Divider(height: 10),
                const HeaderTitle(title: "Productos"),
                PostsItems(user: state.user),
              ],
            ),
          );
        }
        return const Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(color: Colors.black),
          ),
        );
      },
    );
  }
}
