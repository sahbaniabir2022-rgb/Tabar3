import 'package:flutter/material.dart';
import 'screens/accueil_screen.dart';

void main() {
  runApp(const Tabarra3App());
}

class Tabarra3App extends StatelessWidget {
  const Tabarra3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabarra3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      home: const AccueilScreen(),
    );
  }
}
