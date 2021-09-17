import 'package:app_global_heroes/widgets/powerstats_widget.dart';
import 'package:flutter/material.dart';

import 'package:app_global_heroes/models/heroe_model.dart';

class HeroDetailsWidget extends StatefulWidget {
  final HeroeModel hero;
  HeroDetailsWidget({
    required this.hero,
  });

  @override
  _HeroDetailsWidgetState createState() => _HeroDetailsWidgetState();
}

class _HeroDetailsWidgetState extends State<HeroDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Image.network(
                  widget.hero.imagem,
                  fit: BoxFit.cover,
                  height: 280,
                ),
              ),
            ],
          ),
          PowerstatsWidget(
            status: 'Poder',
            valor: widget.hero.power,
            progressoCor: Colors.redAccent,
          ),
          PowerstatsWidget(
            status: 'Inteligência',
            valor: widget.hero.intelligence,
            progressoCor: Colors.blueAccent,
          ),
          PowerstatsWidget(
            status: 'Velocidade',
            valor: widget.hero.speed,
            progressoCor: Colors.greenAccent,
          ),
          PowerstatsWidget(
            status: 'Força',
            valor: widget.hero.strength,
            progressoCor: Colors.purpleAccent,
          ),
          PowerstatsWidget(
            status: 'Combate',
            valor: widget.hero.combat,
            progressoCor: Colors.orangeAccent,
          ),
          PowerstatsWidget(
            status: 'Durabilidade',
            valor: widget.hero.durability,
            progressoCor: Colors.amberAccent,
          ),
        ],
      ),
      actions: [],
    );
  }
}
