import 'package:flutter/material.dart';

class SplashLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(15, 32, 38, 1),
              child: Image.asset(
                "assets/splash.gif",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
