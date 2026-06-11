import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/casino_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casino Chips',
      theme: buildCasinoTheme(),
      home: const HomeScreen(),
    );
  }
}
