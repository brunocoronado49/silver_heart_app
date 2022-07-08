import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/presentation/profile/widgets/widgets_profile.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserStateReady) {
          return SafeArea(
            child: ListView(
              children: [
                const ProfileHeader(),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppTheme.thirdColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      ProfileAvatar(user: state.user),
                      const SizedBox(height: 20),
                      ProfileName(user: state.user),
                      ProfileInfo(user: state.user),
                      ProfileBottom(user: state.user),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SubtitleProfile(subtitle: "Contacto"),
                const SizedBox(height: 10),
                const SocialMedia(),
                const SizedBox(height: 20),
                const SubtitleProfile(subtitle: "Publicaciones"),
                const SizedBox(height: 10),
                ProfilePosts(user: state.user),
                const SizedBox(height: 20),
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
