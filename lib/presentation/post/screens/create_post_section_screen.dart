import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/core/helpers/snackbar_helper.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/repository/repository.dart';

class CreatePostSectionScreen extends StatefulWidget {
  const CreatePostSectionScreen(
      {Key? key, this.post, this.imagePicked, this.isSaving = false})
      : super(key: key);

  final Post? post;
  final File? imagePicked;
  final bool isSaving;

  @override
  State<CreatePostSectionScreen> createState() =>
      _CreatePostSectionScreenState();
}

class _CreatePostSectionScreenState extends State<CreatePostSectionScreen> {
  final _priceCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _typeCtrl = TextEditingController();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      "assets/upload-silver.png",
      fit: BoxFit.fill,
    );

    // Checar si existe imagen
    if (widget.imagePicked != null) {
      image = Image.file(
        widget.imagePicked!,
        fit: BoxFit.fill,
      );
    } else if (widget.post?.picture != null &&
        widget.post!.picture!.isNotEmpty) {
      image = CachedNetworkImage(
        imageUrl: widget.post!.picture!,
        progressIndicatorBuilder: (_, __, progress) =>
            CircularProgressIndicator(value: progress.progress),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
        fit: BoxFit.fill,
      );
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final pickedImage =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              // ignore: use_build_context_synchronously
              context.read<CreatePostBloc>().setImage(File(pickedImage.path));
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
        const SizedBox(height: 10),
        TextField(
          controller: _nameCtrl,
          keyboardType: TextInputType.text,
          autocorrect: false,
          minLines: 1,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: "Nombre",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _priceCtrl,
          keyboardType: TextInputType.number,
          autocorrect: false,
          minLines: 1,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: "Precio",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionCtrl,
          keyboardType: TextInputType.text,
          autocorrect: false,
          minLines: 1,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: "Descripción",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _typeCtrl,
          keyboardType: TextInputType.text,
          autocorrect: false,
          minLines: 1,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: "Tipo de producto",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Stack(children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton.extended(
              onPressed: widget.isSaving
                  ? null
                  : () {
                      context.read<CreatePostBloc>().savePost(
                            _priceCtrl.text.trim(),
                            _typeCtrl.text.trim(),
                            _nameCtrl.text.trim(),
                            _descriptionCtrl.text.trim(),
                            (context.read<UserBloc>().state as UserStateReady)
                                .user
                                .name,
                            (context.read<AuthCubit>().state
                                    as AuthStateSingedIn)
                                .user
                                .uid,
                          );
                    },
              label: const Text("Guardar post"),
              icon: const Icon(Icons.save_outlined),
              backgroundColor: Colors.black87,
              elevation: 0,
            ),
          ),
          if (widget.isSaving) const CircularProgressIndicator(),
        ]),
      ],
    );
  }
}
