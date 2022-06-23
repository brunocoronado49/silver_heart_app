import 'package:flutter/material.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({ required this.color });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const Center(
        child: Text("Custom Screen"),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   static Widget create(BuildContext context) {
//     return BlocProvider(
//       create: (_) => UserBloc(MyUserRepositoryImplement())..getUser(),
//       child: const HomeScreen(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Productos"),
//         backgroundColor: Colors.white38,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: 'Salir',
//             onPressed: () => context.read<AuthCubit>().signOut(),
//           )
//         ],
//       ),
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (_, state) {
//           if (state is UserStateReady) {
//             return MyUserSection(
//               user: state.user,
//               pickedImage: state.pickedImage,
//               isSaving: state.isSaving,
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }