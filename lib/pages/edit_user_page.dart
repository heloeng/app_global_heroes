import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import 'login_page.dart';
import 'package:file_picker/file_picker.dart';


// Define  um widget Form customizado
class EditUser extends StatefulWidget {
  final UserModel edituser;

  EditUser({required this.edituser});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  // Define a classe State que vai tratar os dados do Form
  final _formKey = GlobalKey<FormState>();
  late final nomeCont = TextEditingController()..text = widget.edituser.nome;
  late final nickNameCont = TextEditingController()..text = widget.edituser.nickName;
 
  Uint8List? file;

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    // Cria o widget Form usando  _formKey
    return Scaffold(
      appBar:AppBar (),
      body: Column(children: [
        Expanded(
          child: Container(
            color: Color.fromRGBO(16, 16, 16, 1),
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
                          controller: nomeCont,
                          decoration: InputDecoration(labelText: 'Nome'),
                          // onChanged: (texto) => nome = texto,
                          // validator: (String? texto) {
                            //string null label testar se
                            //se o texto é diferente de nulo e não está vazio
                            // if (texto != null && texto.isNotEmpty) {
                            //   print(texto.length);
                            //   if (texto.length < 3) {
                            //     return "Digite um Nome válido.";
                            //   }
                            // } else {
                            //   return "Campo obrigatório.";
                            // }
                          // },
                        ),
                        
                        TextFormField(
                          controller: nickNameCont,
                          decoration: InputDecoration(labelText: 'Nickname'),
                          // onChanged: (texto) => nickName = texto,
                          // validator: (String? texto) {
                            //string null label testar se
                            //se o texto é diferente de nulo e não está vazio
                          //   if (texto != null && texto.isNotEmpty) {
                          //     print(texto.length);
                          //     if (texto.length < 1) {
                          //       return "Digite um Nickname válido.";
                          //     }
                          //   } else {
                          //     return "Campo obrigatório.";
                          //   }
                          // },
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
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null) {
                    //Esse if/else irá verificar a plataforma utilizada pelo usuário
                    //para tratar a leitura da imagem.
                    if (UniversalPlatform.isAndroid) {
                      //path recebe o caminho da imagem na plataforma
                      final path = result.files.first.path;
                      //image cria um file.dart com o caminho da imagem
                      final image = File(path!);
                      //bytes coverte a imagem em bytes para subir para o firebase
                      final bytes = await image.readAsBytes();
                      file = bytes;
                    } else if (UniversalPlatform.isWeb) {
                      final bytes = result.files.first.bytes;
                      print('Bytes: $bytes');
                      file = bytes;
                      print('File: $file');
                    }

                    // O setState deve permanecer, mesmo que vazio, para atualizar
                    setState(() {});
                  }
                },
                child: Row(
                  children: [
                    Icon(file != null ? Icons.check : Icons.upload),
                    Text("Adicionar imagem"),
                  ],
                ),
              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final List<String> favoritos = [];
                                final user = UserModel(
                                    key: userController.model.key,
                                    nome: nomeCont.text,
                                    email: userController.model.email,
                                    nickName: nickNameCont.text,
                                    favoritos: favoritos,
                                    image:file
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
