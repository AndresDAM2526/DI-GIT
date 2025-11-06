import 'package:flutter/material.dart';
import 'package:flutter_ejercicio_21/paginaprincipal.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {

   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Paginaprincipal()
    );
  }
}
