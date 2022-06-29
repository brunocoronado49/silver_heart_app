import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/presentation/profile/widgets/profile_avatar.dart';
import 'package:silver_heart/presentation/profile/widgets/profile_bottom.dart';
import 'package:silver_heart/presentation/profile/widgets/profile_info.dart';
import 'package:silver_heart/presentation/profile/widgets/profile_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserStateReady) {
          return SafeArea(
            bottom: false,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(bottom: 200),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                  ),
                  child: ProfileAvatar(user: state.user),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ProfileName(user: state.user),
                ),
                ProfileInfo(user: state.user),
                // TODO: Implements posts user
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: ProfileBottom(user: state.user)
                ),
              ],
            ),
          );
        }
        return const Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
