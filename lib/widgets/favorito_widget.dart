import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/user_controller.dart';
import '../models/hero_model.dart';
import '../models/user_model.dart';

class FavoritoWidget extends StatefulWidget {
  final HeroModel hero;

  const FavoritoWidget({
    required this.hero,
  });

  @override
  _FavoritoWidgetState createState() => _FavoritoWidgetState();
}

class _FavoritoWidgetState extends State<FavoritoWidget> {
  UserModel? user;
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

        snapshot.data!.docs.forEach(
          (element) {
            user = UserModel.fromMap(
              element.data(),
            );
          },
        );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FaIcon(
            user!.favoritos!.contains(widget.hero.id)
                ? FontAwesomeIcons.solidStar
                : FontAwesomeIcons.star,
            size: 20,
            color: Color(0xff171b22),
          ),
        );
      },
    );
  }
}
