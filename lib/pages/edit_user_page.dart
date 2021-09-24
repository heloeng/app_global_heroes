import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import 'package:file_picker/file_picker.dart';

// Define  um widget Form customizado
class EditUser extends StatefulWidget {
  final UserModel edituser;

  EditUser({required this.edituser});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  late final nomeCont = TextEditingController()..text = widget.edituser.nome;
  late final nickNameCont = TextEditingController()
    ..text = widget.edituser.nickName;

  Uint8List? file;
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(16, 16, 16, 1),
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nomeCont,
                              decoration: InputDecoration(labelText: 'Nome'),
                            ),
                            TextFormField(
                              controller: nickNameCont,
                              decoration:
                                  InputDecoration(labelText: 'Nickname'),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final result = await FilePicker.platform
                                      .pickFiles(type: FileType.image);
                                  if (result != null) {
                                    if (UniversalPlatform.isAndroid) {
                                      final path = result.files.first.path;
                                      final image = File(path!);
                                      final bytes = await image.readAsBytes();
                                      file = bytes;
                                    } else if (UniversalPlatform.isWeb) {
                                      final bytes = result.files.first.bytes;
                                      print('Bytes: $bytes');
                                      file = bytes;
                                      print('File: $file');
                                    }

                                    setState(() {});
                                  } else {
                                    file = widget.edituser.image;
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(file != null
                                        ? Icons.check
                                        : Icons.upload),
                                    Text("Adicionar imagem"),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final user = UserModel(
                                      key: userController.model.key,
                                      nome: nomeCont.text,
                                      email: userController.model.email,
                                      nickName: nickNameCont.text,
                                      favoritos: widget.edituser.favoritos,
                                      image: file == null
                                          ? widget.edituser.image
                                          : file,
                                    ).toMap();

                                    await FirebaseFirestore.instance
                                        .collection('usuarios')
                                        .doc(userController.user!.uid)
                                        .update(user);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("Editar usuário"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text("Excluir conta"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
