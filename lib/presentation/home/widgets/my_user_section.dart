import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silver_heart/bloc/auth_bloc/auth_bloc.dart';
import 'package:silver_heart/bloc/user_bloc/user_bloc.dart';
import 'package:silver_heart/models/User.dart';

class MyUserSection extends StatefulWidget {
  const MyUserSection(
      {Key? key, this.user, this.pickedImage, this.isSaving = false})
      : super(key: key);

  final MyUser? user;
  final File? pickedImage;
  final bool isSaving;

  @override
  State<MyUserSection> createState() => _MyUserSectionState();
}

class _MyUserSectionState extends State<MyUserSection> {
  final _nameCtrl = TextEditingController();
  final _lastnameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    _nameCtrl.text = widget.user?.name ?? '';
    _lastnameCtrl.text = widget.user?.lastName ?? '';
    _ageCtrl.text = widget.user?.age.toString() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/avatar.png',
      fit: BoxFit.fill,
    );

    if (widget.pickedImage != null) {
      image = Image.file(
        widget.pickedImage!,
        fit: BoxFit.fill,
      );
    } else if (widget.user?.image != null && widget.user!.image!.isEmpty) {
      image = CachedNetworkImage(
        imageUrl: widget.user!.image!,
        progressIndicatorBuilder: (_, __, progress) =>
            CircularProgressIndicator(value: progress.progress),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
        fit: BoxFit.fill,
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  // ignore: use_build_context_synchronously
                  context.read<UserBloc>().setImage(File(pickedImage.path));
                }
              },
              child: Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: image,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (_, current) => current is AuthStateSingedIn,
              builder: (_, state) {
                return Center(
                  child: Text('UID: ${(state as AuthStateSingedIn).user.uid}'),
                );
              },
            ),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _lastnameCtrl,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ageCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 8),
            Stack(alignment: Alignment.center, children: [
              ElevatedButton(
                onPressed: widget.isSaving ? null : () {
                  context.read<UserBloc>()
                    .saveMyUser((context.read<AuthCubit>()
                    .state as AuthStateSingedIn)
                      .user
                      .uid,
                      _nameCtrl.text,
                      _lastnameCtrl.text,
                      int.tryParse(_ageCtrl.text) ?? 0,
                    );
                  },
                child: const Text('Save'),
              ),
              if (widget.isSaving) const CircularProgressIndicator(),
            ]),
          ],
        ),
      ),
    );
  }
}
