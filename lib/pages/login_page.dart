import '../controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Color.fromRGBO(15, 32, 38, 1),
        ),
        child: Form(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (texto) => email = texto,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (texto) => senha = texto,
              ),
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
                      } else {
                        msg = "Ocorreu um erro";
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
                ),
              ),
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
                  child: Text("Criar conta"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
