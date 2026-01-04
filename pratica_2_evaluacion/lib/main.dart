import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pratica_2_evaluacion/Producto.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DatabaseProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int indicePagina = 0;
  List<Widget> paginas = [Productos(), Facturas(), Ajustes()];
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, value, __) => MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                indicePagina = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory),
                label: "Inventario",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.blinds_closed_sharp),
                label: "Facturas",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Ajustes",
              ),
            ],
          ),
          body: paginas[indicePagina],
        ),
      ),
    );
  }
}

class Productos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Inventario"))),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => anadirProductos()),
            );
          },
          child: Text("Añadir producto"),
        ),
      ),
    );
  }
}

class Facturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Facturas"))),
      body: Center(child: Text("Facturas")),
    );
  }
}

class Ajustes extends StatefulWidget {
  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  bool modoOscuro = false;
  double tamanio = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Ajustes"))),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Modo oscuro"),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Switch(
                        value: modoOscuro,
                        onChanged: (value) {
                          setState(() {
                            modoOscuro = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Tamaño de la fuente"),
                    Slider(
                      value: tamanio,
                      onChanged: (value) {
                        setState(() {
                          tamanio = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class anadirProductos extends StatefulWidget {
  @override
  State<anadirProductos> createState() => _anadirProductosState();
}

class _anadirProductosState extends State<anadirProductos> {
  final validadFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<List<String>> categorias = context
        .read<DatabaseProvider>()
        .cargarCategorias();
    String? categoriaSeleccionada;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Añadir producto"))),
      body: Form(
        key: validadFormulario,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Introduzca el nombre";
                        }
                      },
                      decoration: InputDecoration(label: Text("Nombre")),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: context
                          .read<DatabaseProvider>()
                          .cargarCategorias(),
                      builder: (context, snapshot) {
                        final categorias = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          hint: Text("Seleccione una categoria"),
                          items: categorias
                              .map(
                                (categoria) => DropdownMenuItem(
                                  child: Text(categoria),
                                  value: categoria,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              categoriaSeleccionada = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Introduzca la cantidad";
                        } else if (!RegExp(r'[0-9]+\$').hasMatch(value!)) {
                          return "El formato introducido es incorrecto";
                        }
                      },
                      decoration: InputDecoration(label: Text("Cantidad")),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Introduzca un precio";
                        } else if (double.tryParse(value) == null) {
                          return "El formato introducido es incorrecto";
                        }
                      },
                      decoration: InputDecoration(label: Text("Precio")),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    if (validadFormulario.currentState!.validate()) {}
                  },
                  child: Text("Añadir"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatabaseProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _categorias = [];
  List<Map<String, dynamic>> get categorias => _categorias;
  late final Future<Database> database;

  DatabaseProvider() {
    database = _loadDatabase();
  }

  Future<Database> _loadDatabase() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final dbPath = join(
      await databaseFactory.getDatabasesPath(),
      'inventario.db',
    );
    final database = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE IF NOT EXISTS categoria(
                          idCategoria INTEGER PRIMARY KEY AUTOINCREMENT,
                          categoria TEXT NOT NULL
                    )''');
          await db.execute('''CREATE TABLE IF NOT EXISTS producto(
                          idProducto INTEGER PRIMARY KEY AUTOINCREMENT,
                          nombre TEXT NOT NULL,
                          idCategoria INTEGER NOT NULL,
                          cantidad INTEGER NOT NULL,
                          precio REAL NOT NULL,

                          FOREIGN KEY (idCategoria) references categoria(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE
                    )''');
          await db.insert('categoria', {'categoria': 'Hardware'});
          await db.insert('categoria', {'categoria': 'Perifericos'});
          await db.insert('categoria', {'categoria': 'Audio'});
          await db.insert('categoria', {'categoria': 'Smartphone'});
          await db.insert('categoria', {'categoria': 'Redes'});
        },
      ),
    );

    return database;
  }

  Future<void> anadirProducto(Producto producto) async {
    final db = await database;
    await db.insert('producto', {
      'nombre': producto.nombre,
      'categoria': producto.categoria,
      'cantidad': producto.cantidad,
      'precio': producto.precio,
    });
  }

  Future<List<String>> cargarCategorias() async {
    final db = await database;
    _categorias = await db.query('categoria', columns: ['categoria']);
    return _categorias
        .map((categoria) => categoria['categoria'].toString())
        .toList();
  }
}
