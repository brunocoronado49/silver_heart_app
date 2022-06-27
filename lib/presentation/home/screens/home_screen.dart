import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/auth_bloc/auth_bloc.dart';
import 'package:silver_heart/bloc/user_bloc/user_bloc.dart';
import 'package:silver_heart/presentation/feed/screens/feed_screen.dart';
import 'package:silver_heart/presentation/post/screens/create_post_screen.dart';
import 'package:silver_heart/presentation/profile/screens/profile_screen.dart';
import 'package:silver_heart/presentation/profile/screens/settings_profile.dart';
import 'package:silver_heart/presentation/search/screens/search_screen.dart';
import 'package:silver_heart/repository/implementations/user_repository_implement.dart';

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
      appBar: AppBar(
        title: const Text(
          "Silver App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black,),
            tooltip: 'Salir',
            onPressed: () => context.read<AuthCubit>().signOut(),
          )
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          if (state is UserStateReady) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                FeedScreen(),
                Searchcreen(),
                CreatePostScreen(),
                ProfileScreen(),
                SettingsProfile(),
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
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_search_outlined),
            label: "Search"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: "Post"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings"
          ),
        ],
      ),
    );
  }
}