import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String nome = '';
  String email = '';
  String nickName = '';
  String senha = '';
  String confirmarSenha = '';

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar conta"),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Nome'),
                                onChanged: (texto) => nome = texto,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Email'),
                                onChanged: (texto) => email = texto,
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Nickname'),
                                onChanged: (texto) => nickName = texto,
                              ),
                              TextFormField(
                                decoration: InputDecoration(labelText: 'Senha'),
                                onChanged: (texto) => senha = texto,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Confirmar Senha'),
                                onChanged: (texto) => confirmarSenha = texto,
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final List<String> favoritos = [];
                                    final user = UserModel(
                                        nome: nome,
                                        email: email,
                                        nickName: nickName,
                                        favoritos: favoritos);
                                    await userController.signup(
                                        email, senha, user, favoritos);

                                    Navigator.pop(context);
                                  },
                                  child: Text("Criar conta"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
