import 'dart:convert';

//import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:app_global_heroes/models/search_result_model.dart';
import 'package:app_global_heroes/widgets/cardsHeroes_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:animated_card/animated_card.dart';

class GetHeroesWidget extends StatefulWidget {
  @override
  _GetHeroesWidgetState createState() => _GetHeroesWidgetState();
}

class _GetHeroesWidgetState extends State<GetHeroesWidget> {
  String heroName = 'a';

  Future<SearchResult> fetch() async {
    var url = Uri.parse(
        'https://www.superheroapi.com/api.php/2341455595984511/search/$heroName');
    final response = await http.get(url);

    SearchResult heroes = SearchResult.fromJson(jsonDecode(response.body));
    return heroes;
  }

  TextEditingController heroNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: TextField(
              textAlign: TextAlign.center,
              controller: heroNameController,
              onChanged: (wordToFilter) {
                heroName = wordToFilter;

                if (heroName == "") {
                  heroName = 'a';
                } else {
                  print('mostrar texto: $wordToFilter');

                  fetch().then((value) {
                    setState(() {});
                  });
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Pesquisar Herói',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<SearchResult>(
              future: fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os heróis.'),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (context, index) {
                      var heroe = snapshot.data!.results[index];
                      // return CardHeroes(
                      //   screenHeight: MediaQuery.of(context).size.height,
                      //   fotoUrl: heroe.image.url,
                      //   id: heroe.id,
                      //   name: heroe.name,
                      //   fullName: heroe.biography.fullName,
                      //   hero: heroe,
                      // );

                      return AnimatedCard(
                        direction: AnimatedCardDirection
                            .right, //Initial animation direction
                        initDelay: Duration(
                            milliseconds: 500), //Delay to initial animation
                        duration: Duration(milliseconds: 1000),
                        child: CardHeroes(
                          screenHeight: MediaQuery.of(context).size.height,
                          fotoUrl: heroe.image.url,
                          id: heroe.id,
                          name: heroe.name,
                          fullName: heroe.biography.fullName,
                          hero: heroe,
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
