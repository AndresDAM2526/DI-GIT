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
                var dato=datos[index];
                return Container(
                  decoration: BoxDecoration(border: BoxBorder.all(color: Colors.red)),
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                    leading: Text(dato['userId'].toString()),
                    title: Text(dato['title']),
                    subtitle: Text(dato['body']),
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
  final String datos = await rootBundle.loadString("assets/datos.json");
  final List<dynamic> lista = jsonDecode(datos);
  return lista;
}

