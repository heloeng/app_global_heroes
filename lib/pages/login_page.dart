import 'package:google_fonts/google_fonts.dart';

import '../controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
  String error = "";

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  bool obscureTextPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Color(0xffd17842),
                                ),
                                labelText: 'Email'),
                            onChanged: (texto) => email = texto,
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
                                      obscureTextPassword =
                                          !obscureTextPassword;
                                    });
                                  },
                                  icon: obscureTextPassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                labelText: 'Senha'),
                            obscureText: obscureTextPassword,
                            onChanged: (texto) => senha = texto,
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  await userController.login(email, senha);
                                } on FirebaseAuthException catch (e) {
                                  var msg = "";

                                  if (e.code == "wrong-password") {
                                    msg = "A senha está incorreta";
                                  } else if (e.code == "invalid-email") {
                                    msg = "Email inválido";
                                  } else if (e.code == "user-not-found") {
                                    msg = "Usuário não cadastrado";
                                  } else if (e.code == "too-many-requests") {
                                    msg = "Tente novamente mais tarde";
                                  } else if (e.code ==
                                      "operation-not-allowed") {
                                    msg =
                                        "Login com email e senha não está habilitado";
                                  } else {
                                    msg =
                                        "Informe seu email e senha de cadastro";
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(msg),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: Text("Login"),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffd17842)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Cadastrar",
                                style: GoogleFonts.blackOpsOne(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFFB6C34),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: OutlinedButton(
                              onPressed: () async {
                                try {
                                  await userController.updateSenha(
                                      email, context);
                                } on FirebaseAuthException catch (e) {
                                  var msg = "";
                                  if (e.code == "invalid-email") {
                                    msg = "Email inválido";
                                  } else if (e.code == "user-not-found") {
                                    msg = "Usuário não cadastrado";
                                  } else {
                                    msg = "Informe seu email de cadastro";
                                    print(msg);
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(msg),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Esqueci a senha",
                                style: GoogleFonts.blackOpsOne(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFFB6C34),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
