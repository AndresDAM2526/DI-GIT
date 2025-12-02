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
  MainApp({required this.databaseFactory});

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

  Future<void> modificarUsuarios(String nombre, int edad) async {
    await widget.databaseFactory.update('usuarios', {'edad': edad});
  }

  Future<void> borrarUsuarios(String nombre, int edad) async {
    await widget.databaseFactory.delete(
      'usuarios',
      where: 'nombre=? AND edad=?',
      whereArgs: [nombre, edad],
    );
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
            Container(
              margin: EdgeInsets.all(12),
              child: Form(
                key: validarFormulario,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 50,
                        left: 50,
                        right: 50,
                        bottom: 20,
                      ),
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(20),
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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 50,
                        right: 50,
                        bottom: 25,
                      ),
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(20),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (validarFormulario.currentState!.validate()) {
                      final usuario = await widget.databaseFactory.insert(
                        'usuarios',
                        {'nombre': nombre!.text, 'edad': int.parse(edad!.text)},
                      );
                      _cargarUsuarios();
                      nombre!.clear();
                      edad!.clear();
                    }
                  },
                  child: Text("Enviar"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (validarFormulario.currentState!.validate()) {
                      modificarUsuarios(nombre!.text, int.parse(edad!.text));
                      _cargarUsuarios();
                      nombre!.clear();
                      edad!.clear();
                    }
                  },
                  child: Text("Modificar Edad"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (validarFormulario.currentState!.validate()) {
                      borrarUsuarios(nombre!.text, int.parse(edad!.text));
                      _cargarUsuarios();
                      nombre!.clear();
                      edad!.clear();
                    }
                  },
                  child: Text("Borrar"),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                child: ListView.builder(
                  itemCount: _usuarios.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_usuarios[index]['nombre']),
                        subtitle: Text(_usuarios[index]['edad'].toString()),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
