import 'package:app_global_heroes/widgets/drawer_widget.dart';
import 'package:app_global_heroes/widgets/get_heroes_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text('GLOBAL HEROES',style: GoogleFonts.blackOpsOne(
                            textStyle:
                                TextStyle(fontSize: 28, color: Color(0xFF000000),),
                          ),
                          ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
       
       backgroundColor: Color(0xFFFB6C34),
      ),
      drawer: DrawerWidget(),
      body: GetHeroesWidget(),
    );
  }
}
