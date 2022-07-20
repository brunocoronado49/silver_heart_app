import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    Key? key,
    this.user,
    this.imagePicked,
    this.isSaving = false
  }) : super(key: key);

  final MyUser? user;
  final File? imagePicked;
  final bool isSaving;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _webCtrl = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    _nameCtrl.text = widget.user?.name ?? 'Agrega un nombre';
    _descriptionCtrl.text = widget.user?.description ?? 'Agrega una descripción';
    _addressCtrl.text = widget.user?.address ?? 'Agrega tu dirección';
    _phoneCtrl.text = widget.user?.phone ?? 'Agrega tu teléfono';
    _emailCtrl.text = widget.user?.email ?? FirebaseAuth.instance.currentUser!.email.toString();
    _webCtrl.text = widget.user?.web ?? 'Agrega tu sitio web';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      "assets/profile-user.png",
      fit: BoxFit.fill,
    );

    // Checar si existe imagen
    if (widget.imagePicked != null) {
      image = Image.file(
        widget.imagePicked!,
        fit: BoxFit.fill,
      );
    } else if (widget.user?.image != null && widget.user!.image!.isNotEmpty) {
      image = CachedNetworkImage(
        imageUrl: widget.user!.image!,
        progressIndicatorBuilder: (_, __, progress) =>
            CircularProgressIndicator(value: progress.progress),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
        fit: BoxFit.fill,
      );
    }

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
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
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionCtrl,
            decoration: const InputDecoration(labelText: 'Descripción'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _addressCtrl,
            keyboardType: TextInputType.streetAddress,
            decoration: const InputDecoration(labelText: 'Dirección'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Teléfono'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Correo'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _webCtrl,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(labelText: 'Web'),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: FloatingActionButton.extended(
                  backgroundColor: AppTheme.thirdColor,
                  onPressed: widget.isSaving
                      ? null
                      : () {
                          context.read<UserBloc>().saveMyUser(
                              (context.read<AuthCubit>().state
                                      as AuthStateSingedIn)
                                  .user
                                  .uid,
                              _nameCtrl.text.trim(),
                              _descriptionCtrl.text.trim(),
                              _addressCtrl.text.trim(),
                              _phoneCtrl.text.trim(),
                              _emailCtrl.text.trim(),
                              _webCtrl.text.trim());
                        },
                  label: const Text('Guardar información'),
                  icon: const Icon(
                    Icons.edit_outlined,
                  ),
                ),
              ),
              if (widget.isSaving) const CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
