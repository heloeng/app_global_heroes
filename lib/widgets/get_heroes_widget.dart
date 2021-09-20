import 'dart:convert';

//import 'package:app_global_heroes/models/heroe_model.dart';
import 'package:app_global_heroes/models/search_result_model.dart';
import 'package:app_global_heroes/widgets/cardsHeroes_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetHeroesWidget extends StatefulWidget {
  @override
  _GetHeroesWidgetState createState() => _GetHeroesWidgetState();
}

class _GetHeroesWidgetState extends State<GetHeroesWidget> {
  //variável  "heroName "vai receber o nome digitado(wordToFilter)
  //para não inicializar a aplicativo com a lista vazia , foi acrescentado "Superman"
  //para inicializar a lista preenchida.
  String heroName = 'Superman';

  Future<SearchResult> fetch() async {
    var url = Uri.parse(

        //acrescentar "heroName" para  concatenar com a chamada da api
        'https://www.superheroapi.com/api.php/2341455595984511/search/$heroName');
    final response = await http.get(url);

    SearchResult heroes = SearchResult.fromJson(jsonDecode(response.body));
    return heroes;
  }

//TextEditingController: criar o controller  para um campo de texto editável.
  //Sempre que o usuário modifica um campo de texto com um TextEditingController associado e o
  //campo de texto atualiza o valor. O controlador notifica seus "ouvintes".
  //controle irá "receber" o valor que é digitado.
//controler
  TextEditingController heroNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            //em algumas situações quando usa coluna
            //sem determinar o tamanho. Da  o erro: "estourar a tela"
            //" double.infinity" : ocupa toda largura da tela
            width: double.infinity,
            child: TextField(
              textAlign: TextAlign.center,

              ///"controler" do que é digitado
              controller: heroNameController,

              //a função "fetch() async {" é chamada toda vez que o código é carregado

              //quando digita no "TextField" a função "onChanged" é disparada a cada "caracter" digitado.
              //"wordToFilter" (nome escolhido) é a variavel , que vai pegar o for digitado
              onChanged: (wordToFilter) {
                //variável "heroName" vai receber o valor que foi digitado no "wordToFilter"
                //se não atribuir que a variavel "heroName" vai receber o valor digitado no  "wordToFilter"
                //o campo de pesquisa seria sempre igual com o mesmo valor "stático"  atribuido na chamada da api.
                heroName = wordToFilter;

                // "fetch()" retorna algo futuramente : "Future<SearchResult>"
                //depois que tiver o retorno... então faça alguma coisa
                //"chama" setState e atualiza a tela
                //vai chamar a "url..." passando o valor do "heroName", pois "heroName" recebe o valor digitado.(wordToFilter)
                fetch().then((value) {
                  setState(() {});
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Pesquisar Herói',
              ),
            ),
          ),

          //expandir para o limite da tela
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
                      return CardHeroes(
                        screenHeight: MediaQuery.of(context).size.height,
                        fotoUrl: heroe.image.url,
                        id: heroe.id,
                        name: heroe.name,
                        fullName: heroe.biography.fullName,
                        hero: heroe,
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );

                // return GestureDetector(
                //   onTap: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(builder: (context) => HomePage()));
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
