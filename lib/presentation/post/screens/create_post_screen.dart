import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/repository/repository.dart';

class CreatePostSection extends StatelessWidget {
  const CreatePostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postCubit = CreatePostBloc(PostRepositoryImplements());

    return BlocProvider(
      create: (_) => postCubit,
      child: BlocBuilder<CreatePostBloc, CreatePostState>(
        builder: (_, state) {
          if(state is CreatePostSavedState) {
            return CreatePostScreen(
              post: state.post,
              imagePicked: state.pickedImage,
              isSaving: state.isSaving,
            );
          }
          return const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen(
      {Key? key,
      this.post,
      this.isSaving = false,
      this.imagePicked})
      : super(key: key);

  final Post? post;
  final File? imagePicked;
  final bool isSaving;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _priceCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _typeCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          const Text("Selecciona una imágen tocando la de arriba"),
          const SizedBox(height: 20),
          CreatePostInput(
            _nameCtrl,
            "Nombre",
          ),
          const SizedBox(height: 8),
          CreatePostInput(
            _typeCtrl,
            "Tipo",
          ),
          const SizedBox(height: 8),
          TextFormField(
            autocorrect: false,
            controller: _priceCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Precio",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (value) {
              if (value.toString().isEmpty) {
                return "No dejes el espacio vacío.";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          CreatePostInput(
            _priceCtrl,
            "Precio",
          ),
          const SizedBox(height: 8),
          CreatePostInput(
            _descriptionCtrl,
            "Descripción",
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
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
                          (context.read<AuthCubit>().state as AuthStateSingedIn)
                              .user
                              .uid,
                        );
                  },
            label: const Text("Guardar post"),
            icon: const Icon(Icons.save_outlined),
            backgroundColor: Colors.black87,
            elevation: 0,
          ),
          if (widget.isSaving) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
