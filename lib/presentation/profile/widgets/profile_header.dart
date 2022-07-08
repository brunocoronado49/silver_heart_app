import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Perfil',
            style: TextStyle(
              color: AppTheme.thirdColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.thirdColor),
            tooltip: 'Salir',
            onPressed: () => context.read<AuthCubit>().signOut(),
          )
        ],
      ),
    );
  }
}