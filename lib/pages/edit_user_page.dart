import 'dart:io';
import 'dart:typed_data';
import 'package:app_global_heroes/pages/splash_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late final emailCont = TextEditingController()..text = widget.edituser.email;

  Uint8List? file;
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDITAR USUÁRIO',
          style: GoogleFonts.blackOpsOne(
            textStyle: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFB6C34),
      ),
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
                            TextFormField(
                              controller: emailCont,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            const SizedBox(height: 80),
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

                                      file = bytes;
                                    }

                                    setState(() {});
                                  } else {
                                    file = widget.edituser.image;
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFB6C34)),
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
                                  var checkPop = true;
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final user = UserModel(
                                      key: widget.edituser.key,
                                      nome: nomeCont.text,
                                      email: emailCont.text,
                                      nickName: nickNameCont.text,
                                      favoritos: widget.edituser.favoritos,
                                      image: file == null
                                          ? widget.edituser.image
                                          : file,
                                    ).toMap();
                                    try {
                                      await userController.updateUser(
                                          emailCont.text, user);
                                    } on FirebaseException catch (e) {
                                      var msg = "";

                                      if (e.code == "email-already-in-use") {
                                        msg =
                                            "O email fornecido já está em uso por outro usuário";
                                      } else {
                                        msg =
                                            "Informe um email válido para alteração";
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(msg),
                                        ),
                                      );
                                      checkPop = false;
                                    }
                                    if (checkPop) Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffd17842)),
                                child: Text("Editar usuário"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: TextButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Excluir Conta"),
                                        content:
                                            Text("Deseja excluir sua conta?"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text(
                                              'Sim',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              await userController.delete();

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Conta excluída com sucesso"),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: Text('ok'),
                                                        onPressed: () {
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SplashPage(),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xFFcc0000)),
                                          ),
                                          ElevatedButton(
                                            child: Text('Não'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xffd17842)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Excluir conta",
                                  style: GoogleFonts.blackOpsOne(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFcc0000),
                                    ),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Color(0xFFcc0000)),
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
