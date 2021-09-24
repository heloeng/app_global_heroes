// ignore: unused_import
import 'dart:typed_data';
import 'package:app_global_heroes/pages/edit_user_page.dart';
import 'package:app_global_heroes/pages/favoritos_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/user_controller.dart';
// ignore: unused_import
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<UserModel> user = [];

  @override
  Widget build(BuildContext context) {
    late final userController =
        Provider.of<UserController>(context, listen: false);
    return Drawer(
      elevation: 30,
      child: Container(
        color: Colors.black54,
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('usuarios')
                    .where('key', isEqualTo: userController.user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  user = snapshot.data!.docs.map((map) {
                    final data = map.data();
                    return UserModel.fromMap(data);
                  }).toList();

                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        // color: Color(0xFF1E392A),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/giphy4.gif",
                            ),
                            fit: BoxFit.fill)),
                    currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                      child: user[0].image != null
                          ? Image.memory(user[0].image!,
                              width: 144, height: 144, fit: BoxFit.cover)
                          : Icon(Icons.person),
                    )),
                    accountName: Text(user[0].nome),
                    accountEmail: Text(user[0].email),
                  );
                }),
            ListTile(
                title: Text("Favoritos"),
                leading: FaIcon(
                  FontAwesomeIcons.solidStar,
                  color: Color(0xffd17842),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavoritosPage()));
                }),
            ListTile(
                title: Text("Editar Usuário"),
                leading: FaIcon(
                  FontAwesomeIcons.userAlt,
                  color: Color(0xffd17842),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUser(
                                edituser: user[0],
                              )));
                }),
            ListTile(
              title: Text('Sair'),
              leading: FaIcon(
                FontAwesomeIcons.signOutAlt,
                color: Color(0xffd17842),
              ),
              onTap: () async {
                // await userController.logout();

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Sign Out'),
                        content: Text('Deseja sair da conta?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('Sim'),
                            onPressed: () async {
                              await userController.logout();
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            // color: Colors.blueAccent,
                            // child: Text('Não', style: TextStyle(color: Colors.white),),
                            child: Text('Não'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
