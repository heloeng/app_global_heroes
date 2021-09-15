// ignore: unused_import
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
            title: Text('Sign Out'),
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            onTap: () async {
              await userController.logout();
            },
          ),
        ],
      ),
    );
  }
}
