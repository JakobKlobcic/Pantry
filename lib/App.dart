import 'package:flutter/material.dart';
import 'screens/Home.dart';
import 'style.dart';
import 'shell.dart';
import 'theme/byu_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Shell(),
      theme: BYUTheme.byuTheme,
    );
  }
}