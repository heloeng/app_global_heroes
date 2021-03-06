import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
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
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_add_alt,
                                    color: Color(0xffd17842),
                                  ),
                                  labelText: 'Nome'),
                              onChanged: (texto) => nome = texto,
                              validator: (String? texto) {
                                if (texto != null && texto.isNotEmpty) {
                                  if (texto.length < 3) {
                                    return "Digite um Nome v??lido.";
                                  }
                                } else {
                                  return "Campo obrigat??rio.";
                                }
                              },
                            ),
                            TextFormField(
                              validator: (String? texto) {
                                if (texto != null && texto.isNotEmpty) {
                                  if (!texto.contains('@') ||
                                      texto.length < 8) {
                                    return 'Digite um email v??lido';
                                  }
                                } else {
                                  return 'Campo obrigat??rio.';
                                }
                              },
                              onChanged: (texto) => email = texto,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Color(0xffd17842),
                                ),
                                labelText: 'Email',
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_add_alt,
                                    color: Color(0xffd17842),
                                  ),
                                  labelText: 'Nickname'),
                              onChanged: (texto) => nickName = texto,
                              validator: (String? texto) {
                                if (texto != null && texto.isNotEmpty) {
                                  if (texto.length < 1) {
                                    return "Digite um Nickname v??lido.";
                                  }
                                } else {
                                  return "Campo obrigat??rio.";
                                }
                              },
                            ),
                            TextFormField(
                              onChanged: (texto) => senha = texto,
                              obscureText: obscureTextPassword,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.enhanced_encryption_outlined,
                                  color: Color(0xffd17842),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureTextPassword =
                                          !obscureTextPassword;
                                    });
                                  },
                                  icon: obscureTextPassword
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                                labelText: 'Senha',
                              ),
                              validator: (String? texto) {
                                if (texto != null && texto.isNotEmpty) {
                                  if (texto.length < 6) {
                                    return "Digite uma senha com 6 caracteres ou mais";
                                  }
                                } else {
                                  return "Campo obrigat??rio";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.enhanced_encryption_outlined,
                                    color: Color(0xffd17842),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureTextConfirmPassword =
                                            !obscureTextConfirmPassword;
                                      });
                                    },
                                    icon: obscureTextConfirmPassword
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                  labelText: 'Confirmar Senha'),
                              onChanged: (texto) => confirmarSenha = texto,
                              obscureText: obscureTextConfirmPassword,
                              validator: (String? texto) {
                                if (texto != null && texto.isNotEmpty) {
                                  if (texto != senha) {
                                    return "A senha n??o confere";
                                  }
                                } else {
                                  return "Campo obrigat??rio";
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
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
                                            "O email fornecido j?? est?? em uso por outro usu??rio";
                                      } else {
                                        msg = "Ocorreu um erro inesperado";
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(msg),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text("Criar conta"),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffd17842)),
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
                                child: Text(
                                  "Tenho Cadastro",
                                  style: GoogleFonts.blackOpsOne(
                                    textStyle: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFFFB6C34),
                                    ),
                                  ),
                                ),
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
