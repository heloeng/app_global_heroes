import 'package:app_global_heroes/widgets/powerstats_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Color(0xff171b22),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  icon: FaIcon(FontAwesomeIcons.solidTimesCircle)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.network(
                      widget.hero.image.url,
                      fit: BoxFit.contain,
                      height: 280,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/no-image.jpeg',
                          height: 280,
                        );
                      },
                    ),
                  ),
                ],
              ),
              PowerstatsWidget(
                status: 'Poder',
                valor: widget.hero.powerstats.power,
                progressoCor: Color(0xffe63946),
              ),
              PowerstatsWidget(
                status: 'Inteligência',
                valor: widget.hero.powerstats.intelligence,
                progressoCor: Color(0xff457b9d),
              ),
              PowerstatsWidget(
                status: 'Velocidade',
                valor: widget.hero.powerstats.speed,
                progressoCor: Color(0xff2a9d8f),
              ),
              PowerstatsWidget(
                status: 'Força',
                valor: widget.hero.powerstats.strength,
                progressoCor: Color(0xff5c4d7d),
              ),
              PowerstatsWidget(
                status: 'Combate',
                valor: widget.hero.powerstats.combat,
                progressoCor: Color(0xffee6c4d),
              ),
              PowerstatsWidget(
                status: 'Durabilidade',
                valor: widget.hero.powerstats.durability,
                progressoCor: Color(0xfff9c74f),
              ),
            ],
          ),
        ],
      ),
      actions: [],
    );
  }
}
