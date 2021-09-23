import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import 'login_page.dart';
import 'package:file_picker/file_picker.dart';

// Define  um widget Form customizado
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Define a classe State que vai tratar os dados do Form
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String email = '';
  String nickName = '';
  String senha = '';
  String confirmarSenha = '';
  Uint8List? file;

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    // Cria o widget Form usando  _formKey
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Container(
            color: Colors.black87,
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          // O validador recebe o texto digitado
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_add_alt),
                              labelText: 'Nome'),
                          onChanged: (texto) => nome = texto,
                          validator: (String? texto) {
                            //string null label testar se
                            //se o texto é diferente de nulo e não está vazio
                            if (texto != null && texto.isNotEmpty) {
                              if (texto.length < 3) {
                                return "Digite um Nome válido.";
                              }
                            } else {
                              return "Campo obrigatório.";
                            }
                          },
                        ),
                        TextFormField(
                          validator: (String? texto) {
                            if (texto != null && texto.isNotEmpty) {
                              if (!texto.contains('@') || texto.length < 8) {
                                return 'Digite um email válido';
                              }
                            } else {
                              return 'Campo obrigatório.';
                            }
                          },
                          onChanged: (texto) => email = texto,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail_outline,
                            ),
                            labelText: 'Email',
                            //border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_add_alt),
                              labelText: 'Nickname'),
                          onChanged: (texto) => nickName = texto,
                          validator: (String? texto) {
                            //string null label testar se
                            //se o texto é diferente de nulo e não está vazio
                            if (texto != null && texto.isNotEmpty) {
                              if (texto.length < 1) {
                                return "Digite um Nickname válido.";
                              }
                            } else {
                              return "Campo obrigatório.";
                            }
                          },
                        ),
                        TextFormField(
                          onChanged: (texto) => senha = texto,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.enhanced_encryption_outlined),
                            labelText: 'Senha',
                            //border:OutlineInputBorder(),
                          ),
                          validator: (String? texto) {
                            if (texto != null && texto.isNotEmpty) {
                              if (texto.length < 6) {
                                return "Digite uma senha com 6 caracteres ou mais";
                              }
                            } else {
                              return "Campo obrigatório";
                            }
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.enhanced_encryption_outlined),
                              labelText: 'Confirmar Senha'),
                          onChanged: (texto) => confirmarSenha = texto,
                          obscureText: true,
                          validator: (String? texto) {
                            if (texto != null && texto.isNotEmpty) {
                              if (texto.length < 6) {
                                return "Digite uma senha com 6 caracteres ou mais";
                              }
                            } else {
                              return "Campo obrigatório";
                            }
                          },
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(20),
                        //   child: ElevatedButton(
                        //     onPressed:() async {
                        //       final result =
                        //         await FilePicker.platform.pickFiles(type:FileType.image);

                        //     if (result != null) {
                        //       setState((){
                        //         final bytes = result.files.first.bytes;
                        //         file = bytes;
                        //       });
                        //     }
                        //     },
                        //     style: ElevatedButton.styleFrom(primary: Color(0XDD8e4fab)),
                        //     child: Text("Add Imagem"),
                        //   ),
                        // ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final List<String> favoritos = [];
                                final user = UserModel(
                                    nome: nome,
                                    email: email,
                                    nickName: nickName,
                                    favoritos: favoritos);
                                try {
                                  await userController.signup(
                                      email, senha, user, favoritos);
                                  Navigator.pop(context);
                                } on FirebaseAuthException catch (e) {
                                  var msg = "";

                                  if (e.code == "email-already-in-use") {
                                    msg =
                                        "O e-mail fornecido já está em uso por outro usuário";
                                  } else {
                                    msg = "Ocorreu um erro";
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(msg),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text("Criar conta"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text("Tenho Cadastro"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
