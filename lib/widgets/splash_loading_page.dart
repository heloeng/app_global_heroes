import 'package:flutter/material.dart';

class SplashLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}
