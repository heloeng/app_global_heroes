// ignore: unused_import
import 'package:app_global_heroes/pages/favoritos_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/user_controller.dart';
// ignore: unused_import
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final userController =
        Provider.of<UserController>(context, listen: false);

    return Drawer(
      elevation: 30,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userController.model.nome),
            accountEmail: Text(userController.user!.email!),
          ),
          ListTile(
            title: Text("Favoritos"),
            onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritosPage()));}
          ),
          ListTile(
            title: Text('Sign Out'),
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
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
    );
  }
}
