import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_global_heroes/controllers/user_controller.dart';
import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:app_global_heroes/models/user_model.dart';

class FavoritoWidget extends StatefulWidget {
  final Heroe hero;

  const FavoritoWidget({
    required this.hero,
  });

  @override
  _FavoritoWidgetState createState() => _FavoritoWidgetState();
}

class _FavoritoWidgetState extends State<FavoritoWidget> {
  late final userController =
      Provider.of<UserController>(context, listen: false);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .where('key', isEqualTo: userController.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final usuarios = snapshot.data!.docs.map((map) {
            final data = map.data();
            return UserModel.fromMap(data);
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite,
              size: 20,
              color: usuarios[0].favoritos!.contains(widget.hero.id)
                  ? Colors.redAccent
                  : Colors.white,
              // color: Colors.white,
            ),
          );
        });
  }
}
