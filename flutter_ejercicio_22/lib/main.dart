import 'package:flutter/material.dart';
import 'package:flutter_ejercicio_22/ajustes.dart';
import 'package:flutter_ejercicio_22/home.dart';
import 'package:flutter_ejercicio_22/perfil.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => Home(),
        '/perfil': (context) => Perfil(),
        '/ajustes': (context) => Ajustes(),
      },
      home: Scaffold(body: Home()),
    );
  }
}
