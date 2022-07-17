import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/core/helpers/snackbar_helper.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';
import 'package:silver_heart/repository/repository.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen(
      {Key? key, this.post, this.isSaving = false, this.imagePicked})
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
  late File? _image;

  var uuid = const Uuid();

  final _postCubit = CreatePostBloc(PostRepositoryImplements());

  final picker = ImagePicker();

  @override
  void initState() {
    _image = null;
    super.initState();
  }

  Future<void> selectImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      context.read<CreatePostBloc>().setImage(_image);
    });
  }

  Future<void> uploadImage(BuildContext context) async {
    String filename = basename(_image!.path);
    final reference =
      FirebaseStorage.instance.ref().child(
        "${FirebaseAuth.instance.currentUser!.uid}/posts/$filename"
      );

    reference.putFile(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 30),
          const HeaderTitle(title: "Crea un nuevo post"),
          BlocProvider(
            create: (context) => _postCubit,
            child: BlocConsumer<CreatePostBloc, CreatePostState>(
                listener: (context, state) {
              if (state is CreatePostReadyState) {
                SnackBarHelper.successSnackBar("Post creado correctamente")
                    .show(context);
              }
            }, builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: _image != null
                      ? Image.file(_image!)
                      : IconButton(
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        onPressed: () async {
                          selectImage(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
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
                      _descriptionCtrl,
                      "Descripción",
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton.extended(
                      onPressed: widget.isSaving
                          ? null
                          : () {
                            uploadImage(context);
                            context.read<CreatePostBloc>().savePost(
                              uuid.v1(),
                              _priceCtrl.text.trim(),
                              _typeCtrl.text.trim(),
                              _nameCtrl.text.trim(),
                              _descriptionCtrl.text.trim(),
                              (context.read<UserBloc>().state
                                as UserStateReady)
                                  .user
                                  .name,
                              (context.read<AuthCubit>().state
                                as AuthStateSingedIn)
                                  .user
                                  .uid,
                            );
                      },
                      label: const Text("Guardar post"),
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      backgroundColor: Colors.black87,
                      elevation: 0,
                    ),
                    if (widget.isSaving) const CircularProgressIndicator(),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
