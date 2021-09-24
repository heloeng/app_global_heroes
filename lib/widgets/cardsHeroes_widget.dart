import 'package:animated_card/animated_card.dart';
import 'package:app_global_heroes/controllers/user_controller.dart';
import 'package:app_global_heroes/models/user_model.dart';
import 'package:app_global_heroes/widgets/favorito_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:provider/provider.dart';
import 'hero_details_widget.dart';

class CardHeroes extends StatelessWidget {
  const CardHeroes({
    Key? key,
    required this.screenHeight,
    required this.fotoUrl,
    required this.name,
    required this.fullName,
    required this.id,
    required this.hero,
  }) : super(key: key);

  final double screenHeight;
  final String fotoUrl;
  final String name;
  final String fullName;
  final String id;
  final Heroe hero;

  @override
  Widget build(BuildContext context) {
    late final userController =
        Provider.of<UserController>(context, listen: false);

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GestureDetector(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AnimatedCard(
                direction:
                    AnimatedCardDirection.right, //Initial animation direction
                initDelay:
                    Duration(milliseconds: 100), //Delay to initial animation
                duration: Duration(milliseconds: 1000),
                child: HeroDetailsWidget(hero: hero),
              );
            },
          );
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: screenHeight * 0.2 - 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff171b22),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Image.network(
                        hero.image.url,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/no-image.jpeg',
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          fullName,
                          style: TextStyle(
                            color: Color(0xffaeaeae),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "ID: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffd17842),
                                  ),
                                ),
                                Text(
                                  id,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffd17842),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // child: FavoritoWiget(hero: hero),
                              child: InkWell(
                                //Esse onTap realiza a requisição ao Firebase dos dados do usuário logado, adiciona à lista de favoritos
                                //o ID do herói e atualiza a lista de favoritos no banco de dados
                                onTap: () async {
                                  final usuario = await FirebaseFirestore
                                      .instance
                                      .collection('usuarios')
                                      .doc(userController.user!.uid)
                                      .get();

                                  final data = usuario.data();

                                  final atualUsuario = UserModel.fromMap(data!);
                                  if (!atualUsuario.favoritos!
                                      .contains(hero.id)) {
                                    atualUsuario.favoritos!.add(hero.id);
                                  } else {
                                    atualUsuario.favoritos!.remove(hero.id);
                                  }

                                  final novoUsuario = UserModel(
                                    nome: atualUsuario.nome,
                                    email: atualUsuario.email,
                                    nickName: atualUsuario.nickName,
                                    key: userController.user!.uid,
                                    favoritos: atualUsuario.favoritos,
                                    image: atualUsuario.image,
                                  ).toMap();

                                  FirebaseFirestore.instance
                                      .collection('usuarios')
                                      .doc(userController.user!.uid)
                                      .update(novoUsuario);
                                },
                                child: FavoritoWidget(
                                  hero: hero,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
