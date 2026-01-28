import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  List<int> numeroPares(List<int> lista) {
    return lista.where((numero) => numero % 2 == 0).toList();
  }

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> numeros = [1, 2, 3, 4, 5, 6, 7];
    List<int> listaFiltrada = numeroPares(numeros);
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: listaFiltrada.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text("${listaFiltrada[index]}"));
          },
        ),
      ),
    );
  }
}
