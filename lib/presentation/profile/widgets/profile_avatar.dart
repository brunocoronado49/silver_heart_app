import 'dart:io';

import 'package:flutter/material.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key, this.avatar}) : super(key: key);

  final File? avatar;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: AppTheme.thirdColor,
        radius: 70,
        child: widget.avatar != null ?
          Image.network(widget.avatar.toString()) : 
          const Icon(
          Icons.person_outlined,
          color: AppTheme.primaryColor,
          size: 100,
        ),
      ),
    );
  }
}
