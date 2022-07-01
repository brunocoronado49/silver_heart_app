import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/core/helpers/snackbar_helper.dart';
import 'package:silver_heart/models/models.dart';
import 'package:silver_heart/presentation/profile/widgets/widgets_profile.dart';
import 'package:silver_heart/presentation/widgets/widgets.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({Key? key, this.user, this.isSaving = false})
      : super(key: key);

  final MyUser? user;
  final bool isSaving;

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _webCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 30),
          const HeaderTitle(title: "Actualiza tus datos"),
          BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserStateSaved) {
                SnackBarHelper.successSnackBar("Datos guardados correctamente")
                    .show(context);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ProfileInputInfo(
                        _nameCtrl, "Nombre", const Icon(Icons.person_outline)),
                    const SizedBox(height: 8),
                    ProfileInputInfo(_descriptionCtrl, "Descripción",
                        const Icon(Icons.info_outline)),
                    const SizedBox(height: 8),
                    ProfileInputInfo(_addressCtrl, "Dirección",
                        const Icon(Icons.message_outlined)),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneCtrl,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        label: const Text("Teléfono"),
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
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _phoneCtrl,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        label: const Text("Correo"),
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
                    TextFormField(
                      keyboardType: TextInputType.url,
                      controller: _webCtrl,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.web_outlined),
                        label: const Text("Página web"),
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
                    const SizedBox(height: 10),
                    FloatingActionButton.extended(
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
                                    _webCtrl.text.trim(),
                                  );
                            },
                      backgroundColor: Colors.black87,
                      elevation: 0,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text("Guardar Información"),
                    ),
                    if (widget.isSaving) const CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
