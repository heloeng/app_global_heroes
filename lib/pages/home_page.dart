import 'package:app_global_heroes/widgets/drawer_widget.dart';
import 'package:app_global_heroes/widgets/get_heroes_widget.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      body: GetHeroesWidget(),
    );
  }
}
