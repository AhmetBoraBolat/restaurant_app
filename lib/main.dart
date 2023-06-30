import 'package:flutter/material.dart';

import 'util/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 27, 27, 32),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          decoration: TextDecoration.lineThrough,
        )),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromARGB(38, 38, 45, 1),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
