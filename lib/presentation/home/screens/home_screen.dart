import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/presentation/post/screens/multi_images_screen.dart';
import 'package:silver_heart/presentation/post/screens/multi_images_uploaded.dart';
import 'package:silver_heart/presentation/screens.dart';
import 'package:silver_heart/repository/repository.dart';
import 'package:silver_heart/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(MyUserRepositoryImplement())..getUser(),
      child: const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          if (state is UserStateReady) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const FeedScreen(),
                SearchScreen(user: state.user),
                const CreatePostScreen(),
                const MultiImagesScreen(),
                const MultiImagesUploadedScreen(),
                const ProfileScreen(),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          currentPage = index;
          _pageController.animateToPage(
            currentPage,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInCirc
          );
          setState(() {});
        },
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.thirdColor,
        unselectedItemColor: AppTheme.secondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            label: "Buscar"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: "Post"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_outlined),
            label: "Images List"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "All images"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Perfil"
          ),
        ],
      ),
    );
  }
}