import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() async {
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;
  final dbPath = join(await databaseFactory.getDatabasesPath(), 'usuarios.db');
  final db = await databaseFactory.openDatabase(dbPath);
  await db.execute('''CREATE TABLE IF NOT EXISTS usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT NOT NULL,
          edad INTEGER NOT NULL
        )''');
  runApp(MainApp(databaseFactory: db));
}

class MainApp extends StatefulWidget {
  Database databaseFactory;
  MainApp({super.key, required this.databaseFactory});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Map<String, dynamic>> _usuarios = [];

  Future<void> _cargarUsuarios() async {
    final usuarios = await widget.databaseFactory.query('usuarios');
    setState(() {
      _usuarios = usuarios;
    });
  }

  @override
  void initState() {
    _cargarUsuarios();
  }

  final validarFormulario = GlobalKey<FormState>();

  TextEditingController? nombre = TextEditingController();

  TextEditingController? edad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text("Formulario"))),
        body: Column(
          children: [
            Form(
              key: validarFormulario,
              child: Column(
                children: [
                  Card(
                    child: TextFormField(
                      controller: nombre,
                      decoration: InputDecoration(label: Text("Nombre")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Introduzca su nombre";
                        }
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: edad,
                      decoration: InputDecoration(label: Text("Edad")),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Introduzca su edad";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (validarFormulario.currentState!.validate()) {
                  final usuario = await widget.databaseFactory.insert(
                    'usuarios',
                    {'nombre': nombre!.text, 'edad': int.parse(edad!.text)},
                  );
                  _cargarUsuarios();
                  nombre!.text = "";
                  edad!.text = "";
                }
              },
              child: Text("Enviar"),
            ),
            Center(
              child: ListView.builder(
                itemCount: _usuarios.length,
                itemBuilder: (context, index) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
