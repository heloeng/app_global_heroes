import 'package:app_global_heroes/widgets/powerstats_widget.dart';
import 'package:flutter/material.dart';

import 'package:app_global_heroes/models/heroe_model.dart';

class HeroDetailsWidget extends StatefulWidget {
  final Heroe hero;
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
                  widget.hero.image.url,
                  fit: BoxFit.cover,
                  height: 280,
                ),
              ),
            ],
          ),
          PowerstatsWidget(
            status: 'Poder',
            valor: widget.hero.powerstats.power,
            progressoCor: Colors.redAccent,
          ),
          PowerstatsWidget(
            status: 'Inteligência',
            valor: widget.hero.powerstats.intelligence,
            progressoCor: Colors.blueAccent,
          ),
          PowerstatsWidget(
            status: 'Velocidade',
            valor: widget.hero.powerstats.speed,
            progressoCor: Colors.greenAccent,
          ),
          PowerstatsWidget(
            status: 'Força',
            valor: widget.hero.powerstats.strength,
            progressoCor: Colors.purpleAccent,
          ),
          PowerstatsWidget(
            status: 'Combate',
            valor: widget.hero.powerstats.combat,
            progressoCor: Colors.orangeAccent,
          ),
          PowerstatsWidget(
            status: 'Durabilidade',
            valor: widget.hero.powerstats.durability,
            progressoCor: Colors.amberAccent,
          ),
        ],
      ),
      actions: [],
    );
  }
}
