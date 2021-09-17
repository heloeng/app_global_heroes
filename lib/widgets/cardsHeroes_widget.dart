import 'package:flutter/material.dart';
import 'package:app_global_heroes/models/heroe_model.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return HeroDetailsWidget(hero: hero);
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
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                            color: Color(0xff30221f),
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(fotoUrl),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
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
