import 'dart:convert';

//import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:app_global_heroes/models/search_result_model.dart';
import 'package:app_global_heroes/pages/home_page.dart';
import 'package:app_global_heroes/widgets/cardsHeroes_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetHeroesWidget extends StatefulWidget {
  @override
  _GetHeroesWidgetState createState() => _GetHeroesWidgetState();
}

class _GetHeroesWidgetState extends State<GetHeroesWidget> {
  Future<SearchResult> fetch() async {
    var url = Uri.parse(
        'https://www.superheroapi.com/api.php/2341455595984511/search/batman');
    final response = await http.get(url);

    SearchResult heroes = SearchResult.fromJson(jsonDecode(response.body));
    return heroes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchResult>(
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
              return CardHeroes(
                screenHeight: MediaQuery.of(context).size.height,
                fotoUrl: heroe.image.url,
                id: heroe.id,
                name: heroe.name,
                fullName: heroe.biography.fullName,
              );
            },
          );
        }
        //   return Center(
        // child: CircularProgressIndicator(),

        //   )

        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        );
      },
    );
  }
}
