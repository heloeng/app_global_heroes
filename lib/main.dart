import 'package:app_global_heroes/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserController()),
        ],
        builder: (context, _) {
          return MaterialApp(
            title: 'Global Heroes',
            theme: ThemeData(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                secondary: Colors.white,
              ),
              primarySwatch: Colors.deepPurple,
              primaryColor: Color.fromRGBO(255, 255, 255, 1),
              accentColor: Color.fromRGBO(255, 255, 255, 1),
            ),
            home: SplashWidget(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
