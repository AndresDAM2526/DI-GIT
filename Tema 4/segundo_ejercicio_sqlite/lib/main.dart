import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  List<Widget> paginas = [Formulario(), Visor(), Opciones()];

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, value, __) => MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_center),
                label: "Formulario",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.remove_red_eye),
                label: "Visor",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help),
                label: "Opciones",
              ),
            ],
            currentIndex: indicePagina,
            onTap: (value) {
              setState(() {
                indicePagina = value;
              });
            },
          ),
          body: paginas[indicePagina],
        ),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  final validarFormulario = GlobalKey<FormState>();

  TextEditingController? nombre = TextEditingController();

  TextEditingController? edad = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    nombre!.clear();
                    edad!.clear();
                  }
                },
                child: Text("Enviar"),
              ),
              ElevatedButton(
                onPressed: () async {},
                child: Text("Modificar Edad"),
              ),
              ElevatedButton(onPressed: () async {}, child: Text("Borrar")),
            ],
          ),
        ],
      ),
    );
  }
}

class Visor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Visor")));
  }
}

class Opciones extends StatefulWidget {
  @override
  State<Opciones> createState() => _OpcionesState();
}

class _OpcionesState extends State<Opciones> {
  bool modoClaro = false;
  double valorSlider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Opciones"))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Modo claro"),
                    Switch(
                      value: modoClaro,
                      onChanged: (value) {
                        setState(() {
                          modoClaro = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: Column(
                  children: [
                    Text("Tamaño de la fuente"),
                    Slider(
                      value: valorSlider,
                      onChanged: (value) {
                        setState(() {
                          valorSlider = value;
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

class DatabaseProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _usuarios = [];

  List<Map<String, dynamic>> get usuarios => _usuarios;
  late final Future<Database> database;
  DatabaseProvider() {
    database = _loadDatabase();
  }

  Future<Database> _loadDatabase() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final dbPath = join(
      await databaseFactory.getDatabasesPath(),
      'usuarios.db',
    );
    final database = await databaseFactory.openDatabase(dbPath);
    await database.execute('''
      CREATE TABLE IF NOT EXISTS usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT NOT NULL,
          edad INTEGER NOT NULL
        )
    ''');
    return database;
  }

  Future<void> cargarUsuarios() async {
    final db = await database;
    _usuarios = await db.query('usuarios');
    notifyListeners();
  }

  Future<void> anadirUsuario(String nombre, int edad) async {
    final db = await database;
    await db.insert('usaurios', {'nombre': nombre, 'edad': edad});
    notifyListeners();
  }
}
