import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silver_heart/bloc/app_bloc.dart';

import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/theme/app_theme.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection(
      {Key? key, this.user, this.imagePicked, this.isSaving = false})
      : super(key: key);

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
    _nameCtrl.text = widget.user?.name ?? '';
    _descriptionCtrl.text = widget.user?.description ?? '';
    _addressCtrl.text = widget.user?.address ?? '';
    _phoneCtrl.text = widget.user?.phone ?? '';
    _emailCtrl.text = widget.user?.email ?? '';
    _webCtrl.text = widget.user?.web ?? '';
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
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppTheme.thirdColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
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
            decoration: const InputDecoration(labelText: 'Dirección'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneCtrl,
            decoration: const InputDecoration(labelText: 'Teléfono'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: 'Correo'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _webCtrl,
            decoration: const InputDecoration(labelText: 'Web'),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ElevatedButton(
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
                child: const Text('Save'),
              ),
              if (widget.isSaving) const CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
