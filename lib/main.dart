import 'package:app_global_heroes/pages/splash_page.dart';
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
          // ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => UserController()),
        ],
        builder: (context, _) {
          // final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: 'Flutter Demo',
            // themeMode: themeProvider.themeMode,
            // theme: MyThemes.lightTheme,
            // darkTheme: MyThemes.darkTheme,
            home: SplashPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
