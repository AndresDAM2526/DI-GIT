import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: obtenerDatosJson(),
          builder: (context, snapshot) {
            List<dynamic> datos = snapshot.data!;
            return ListView.builder(
              itemCount: datos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(20),
                  child: Card(
                    child: ListTile(
                      title: Text(datos[index]['nombre']),
                      subtitle: Text(datos[index]['precio'].toString()),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Future<List<dynamic>> obtenerDatosJson() async {
  final String productos = await rootBundle.loadString("assets/datos.json");
  final List<dynamic> listaProductos = jsonDecode(productos);
  return listaProductos;
}
