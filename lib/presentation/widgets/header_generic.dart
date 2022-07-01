import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/theme/app_theme.dart';

class HeaderGeneric extends StatelessWidget {
  const HeaderGeneric({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const IconButton(
            icon: Icon(Icons.menu_outlined, color: AppTheme.thirdColor),
            onPressed: null,
          ),
          const Text(
            'Silver Heart',
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