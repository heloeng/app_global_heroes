// import 'package:app_global_heroes/models/heroe_model.dart';
// import 'package:flutter/material.dart';
// //import 'package:segsing/models/heromodel.dart';
// //import 'package:segsing/services/heroservice.dart';

// class HeroPage extends StatefulWidget {
//   const HeroPage({Key? key}) : super(key: key);

//   @override
//   _HeroPageState createState() => _HeroPageState();
// }

// class _HeroPageState extends State<HeroPage> {
//   var heros = <Heroe>[];

//   @override
//   void initState() {
//     _loadingHero();
//     super.initState();
//   }

//   void _loadingHero({String name = 'batman'}) async {
//     heros = await HeroService().getHeros(name);
//     if (heros.length != 0) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tudo sobre os Herois da DC'),
//       ),
//       body: heros.length == 0
//           ? Center(
//               child: Text('Nenhum super heroi encontrado'),
//             )
//           : ListView.builder(
//               itemCount: heros.length,
//               itemBuilder: (context, index) => _cardHero(heros[index]),
//             ),title:TextFormField(
//               keyboardType:TextInputType.text,

//             );
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _loadingHero(name: 'superman'),
//         child: Icon(Icons.search),
//       ),
//     );
//   }

//   Widget _cardHero(HeroModel model) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(model.imageUrl),
//       ),
//       title: Text(model.name),
//       subtitle: Text(model.fullName),
//       trailing: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Inteligencia'),
//           Text('${model.intelligence}%'),
//         ],
//       ),
//     );
//   }
// }
