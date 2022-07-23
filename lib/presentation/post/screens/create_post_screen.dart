import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import 'package:silver_heart/theme/app_theme.dart';
import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/post/widgets/posts_widgets.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen(
      {Key? key, this.isSaving = false, this.imagePicked, this.post})
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
  var uuid = const Uuid();

  final picker = ImagePicker();

  late File? _image;

  @override
  void initState() {
    _nameCtrl.text = widget.post?.name ?? "";
    _descriptionCtrl.text = widget.post?.description ?? "";
    _typeCtrl.text = widget.post?.type ?? "";
    _priceCtrl.text = widget.post?.price ?? "";
    _image = null;
    super.initState();
  }

  Future<void> selectImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  // Upload One Image
  Future<void> uploadImage(BuildContext context) async {
    String filename = basename(_image!.path);
    String type = _typeCtrl.text.trim();
    final reference = FirebaseStorage.instance.ref().child(
      
      // Al principio ponerle un numero por medio de un for
      "/posts/${FirebaseAuth.instance.currentUser?.uid}-$type-$filename}"
    );

    await reference.putFile(
        _image!,
        SettableMetadata(customMetadata: {
          'seller':
              (context.read<UserBloc>().state as UserStateReady).user.name,
          'price': _priceCtrl.text.trim(),
          'name': _nameCtrl.text.trim(),
          'description': _descriptionCtrl.text.trim(),
          'type': _typeCtrl.text.trim(),
          'id': uuid.v1(),
          'userId':
              (context.read<AuthCubit>().state as AuthStateSingedIn).user.uid,
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 30),
          const HeaderTitle(title: "Crea un nuevo post"),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: _image != null
                        ? Image.file(_image!)
                        : GestureDetector(
                          onTap: () {
                            selectImage(context);
                          },
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/add-picture.png",
                              scale: 0.6,
                            ),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                CreatePostInput(
                  _nameCtrl,
                  "Nombre del producto",
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
                        },
                  label: const Text("Guardar post"),
                  icon: const Icon(Icons.update),
                  backgroundColor: AppTheme.thirdColor,
                  elevation: 0,
                ),
                if (widget.isSaving) 
                  const CircularProgressIndicator(color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
