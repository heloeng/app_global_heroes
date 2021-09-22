import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:app_global_heroes/controllers/user_controller.dart';
import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:app_global_heroes/models/search_result_model.dart';
import 'package:app_global_heroes/models/user_model.dart';
import 'package:app_global_heroes/widgets/cardsHeroes_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;



class FavoritosPage extends StatefulWidget {
  const FavoritosPage({ Key? key }) : super(key: key);

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  Future<Heroe> fetch(heroId) async {
    var url = Uri.parse(
        'https://www.superheroapi.com/api.php/2341455595984511/$heroId');
    final response = await http.get(url);
  
    Heroe heroes = Heroe.fromJson(jsonDecode(response.body));
    print("Heroes ${heroes.name}");
    return heroes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Meus Heróis Favoritos '),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .where("key", isEqualTo: userController.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final usuarios = snapshot.data!.docs.map((map) {
            final data = map.data();
            return UserModel.fromMap(data);
          }).toList();

          return ListView.builder(
            itemCount: usuarios[0].favoritos!.length,
            itemBuilder: (context, index) {
              late final favorito = usuarios[0].favoritos![index];
              print("favorito ${favorito}");
              return
              FutureBuilder<Heroe>(
              future: fetch(favorito),
              builder: (context, snapshot) {
                print("Data ${snapshot.data}");
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os heróis.'),
                  );
                }
                if (snapshot.hasData) {
                  final Heroe hero = snapshot.data! ;
                   return AnimatedCard(
                    direction: AnimatedCardDirection
                        .right, //Initial animation direction
                    initDelay: Duration(
                        milliseconds: 500), //Delay to initial animation
                    duration: Duration(milliseconds: 1000),
                    child: CardHeroes(
                      screenHeight: MediaQuery.of(context).size.height,
                      fotoUrl: hero.image.url,
                      id: hero.id,
                      name: hero.name,
                      fullName: hero.biography.fullName,
                      hero: hero,
                    ),
                  );
                };
                
              
                return Center(
                  child: Text(""),
                );
              },
            );
            }
          );
        },
      ),
    );
  }
}