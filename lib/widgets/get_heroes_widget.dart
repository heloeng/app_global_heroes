import 'dart:convert';
import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:app_global_heroes/widgets/hero_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetHeroesWidget extends StatefulWidget {
  @override
  _GetHeroesWidgetState createState() => _GetHeroesWidgetState();
}

class _GetHeroesWidgetState extends State<GetHeroesWidget> {
  Future<List<dynamic>> fetch() async {
    var url = Uri.parse(
        'https://www.superheroapi.com/api.php/2341455595984511/search/batman');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return json['results'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar os heróis.'),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var heroe = HeroeModel.fromMap(snapshot.data![index]);
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => HeroDetailsWidget(hero: heroe));
                    },
                    child: ListTile(
                      title: Text(heroe.name),
                      subtitle: Text(heroe.fullName),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(heroe.imagem),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
