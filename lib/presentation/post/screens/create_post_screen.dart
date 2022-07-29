import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  const CreatePostScreen({Key? key, this.post}) : super(key: key);

  final Post? post;

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

  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  final storageRef = FirebaseStorage.instance;
  List<File> _image = [];
  final picker = ImagePicker();

  // ignore: prefer_typing_uninitialized_variables
  var _imagePortada;

  @override
  void initState() {
    // modificar la coleccion
    imgRef = FirebaseFirestore.instance.collection('posts');
    _nameCtrl.text = widget.post?.name ?? "";
    _descriptionCtrl.text = widget.post?.description ?? "";
    _typeCtrl.text = widget.post?.type ?? "";
    _priceCtrl.text = widget.post?.price ?? "";
    super.initState();
  }

  // Function for pikc images
  Future<void> selectImages() async {
    final pickedImages = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedImages!.path));
    });
    // ignore: unnecessary_null_comparison
    if (pickedImages!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  // Function for upload the images with metadata
  Future<void> uploadImages(BuildContext context) async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      Reference refe = storageRef.ref().child(
        'images/${FirebaseAuth.instance.currentUser!.uid}/${_typeCtrl.text.trim()}/$i'
      );

      UploadTask uploadTask = refe.putFile(
          img,
          SettableMetadata(customMetadata: {
            'seller':
                (context.read<UserBloc>().state as UserStateReady).user.name,
            'price': _priceCtrl.text.trim(),
            'num': i.toString(),
            'name': _nameCtrl.text.trim(),
            'description': _descriptionCtrl.text.trim(),
            'type': _typeCtrl.text.trim(),
            'id': uuid.v1(),
            'userId':
                (context.read<AuthCubit>().state as AuthStateSingedIn).user.uid,
          }));

      await uploadTask.then((res) async {
        await res.ref.getDownloadURL().then((value) async {
          imgRef.add({
            'url': value,
            'seller':
                (context.read<UserBloc>().state as UserStateReady).user.name,
            'price': _priceCtrl.text.trim(),
            'name': _nameCtrl.text.trim(),
            'description': _descriptionCtrl.text.trim(),
            'type': _typeCtrl.text.trim(),
            'id': uuid.v1(),
            'userId':
                (context.read<AuthCubit>().state as AuthStateSingedIn).user.uid,
          });
          i++;
        });
      });
    }
  }

  Future<void> selectImage(BuildContext context) async {
    final pickedImagePortada =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePortada = File(pickedImagePortada!.path);
    });
  }

  // Upload One Image
  Future<void> uploadImage(BuildContext context) async {
    String filename = basename(_imagePortada.path);
    String type = _typeCtrl.text.trim();
    final reference = FirebaseStorage.instance.ref().child(
      "/posts/${FirebaseAuth.instance.currentUser?.uid}.$type.$filename"
    );

    await reference.putFile(
        _imagePortada,
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
                const SizedBox(height: 30),
                FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      uploading = true;
                    });
                    uploadImages(context);
                    uploadImage(context);
                  },
                  label: const Text("Guardar post"),
                  icon: const Icon(Icons.update),
                  backgroundColor: AppTheme.thirdColor,
                  elevation: 0,
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
                const Center(
                  child: Text("Selecciona una imágen que sirva de portada",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                Container(
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: _imagePortada != null
                        ? Image.file(_imagePortada)
                        : GestureDetector(
                            onTap: () {
                              selectImage(context);
                            },
                            child: ClipRRect(
                              child: Image.asset(
                                "assets/add-picture.png",
                                scale: 0.9,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text("Selecciona imágenes para subirlas",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _image.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: Container(
                                color: AppTheme.backgroundColor,
                                child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        !uploading ? selectImages() : null),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image[index - 1]),
                                      fit: BoxFit.cover)),
                            );
                    },
                  ),
                ),
                uploading
                    ? Center(
                        child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              'subiendo...',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(
                            value: val,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.black),
                          )
                        ],
                      ))
                    : const SizedBox(),
                if (uploading)
                  const CircularProgressIndicator(color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
