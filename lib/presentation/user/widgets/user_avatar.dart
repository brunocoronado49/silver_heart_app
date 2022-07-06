import 'package:flutter/material.dart';

import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/theme/app_theme.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  //final MyUser user;

  @override
  Widget build(BuildContext context) {
    return const  Center(
      child: CircleAvatar(
        backgroundColor: AppTheme.thirdColor,
        radius: 70,
        child: //user.image != null ?
          //Image.network(user.image.toString()) : 
          Icon(
            Icons.person_outlined,
            color: AppTheme.primaryColor,
            size: 100,
          ),
      ),
    );
  }
}