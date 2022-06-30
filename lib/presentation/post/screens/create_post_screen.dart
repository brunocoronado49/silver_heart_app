import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/core/helpers/snackbar_helper.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/repository/repository.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key, this.post, this.isSaving = false}) : super(key: key);

  final Post? post;
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
  final _postCubit = CreatePostBloc(PostRepositoryImplements());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const HeaderTitle(title: "Crea un nuevo post"),
          BlocProvider(
            create: (context) => _postCubit,
            child: BlocConsumer<CreatePostBloc, CreatePostState>(
              listener: (context, state) {
                if (state is CreatePostReadyState) {
                  SnackBarHelper.successSnackBar(
                    "Post creado correctamente"
                  ).show(context);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
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
                      CreatePostInput(
                        _priceCtrl,
                        "Precio",
                      ),
                      const SizedBox(height: 8),
                      CreatePostInput(
                        _descriptionCtrl,
                        "Descripción",
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton.extended(
                        onPressed: widget.isSaving ? null : () {
                          context.read<CreatePostBloc>()
                            .savePost(
                              _priceCtrl.text.trim(),
                              _typeCtrl.text.trim(),
                              _nameCtrl.text.trim(),
                              _descriptionCtrl.text.trim(),
                              (context.read<UserBloc>().state as UserStateReady)
                                .user.name,
                              (context.read<AuthCubit>().state as AuthStateSingedIn)
                                .user.uid,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}