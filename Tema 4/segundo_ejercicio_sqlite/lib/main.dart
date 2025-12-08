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
  bool modoClaro = true;
  List<Widget> paginas = [Formulario(), Visor(), Opciones()];

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, value, __) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: value.modoClaro ? ThemeMode.light : ThemeMode.dark,
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
      appBar: AppBar(
        title: Center(
          child: Text("Formulario", style: TextStyle(fontSize: 10)),
        ),
      ),
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
                    context.read<DatabaseProvider>().anadirUsuario(
                      nombre!.text,
                      int.parse(edad!.text),
                    );
                    nombre!.clear();
                    edad!.clear();
                  }
                },
                child: Text("Enviar"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<DatabaseProvider>().modificarEdad(
                    nombre!.text,
                    int.parse(edad!.text),
                  );
                  nombre!.clear();
                  edad!.clear();
                },
                child: Text("Modificar Edad"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<DatabaseProvider>().borrarUsuario(
                    nombre!.text,
                    int.parse(edad!.text),
                  );
                  nombre!.clear();
                  edad!.clear();
                },
                child: Text("Borrar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Visor extends StatefulWidget {
  @override
  State<Visor> createState() => _VisorState();
}

class _VisorState extends State<Visor> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> usuarios = context
        .watch<DatabaseProvider>()
        .usuarios;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Visor"))),
      body: usuarios.isEmpty
          ? Center(child: Text("No hay datos"))
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(12),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(usuarios[index]['nombre']),
                      subtitle: Text(usuarios[index]['edad'].toString()),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class Opciones extends StatefulWidget {
  @override
  State<Opciones> createState() => _OpcionesState();
}

class _OpcionesState extends State<Opciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Opciones",
            style: TextStyle(
              fontSize:
                  3 * (context.read<DatabaseProvider>().multiplicadorFuente),
            ),
          ),
        ),
      ),
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
                    Text(
                      "Modo claro",
                      style: TextStyle(
                        fontSize:
                            2 *
                            (context
                                .read<DatabaseProvider>()
                                .multiplicadorFuente),
                      ),
                    ),
                    Switch(
                      value: context.read<DatabaseProvider>().modoClaro,
                      onChanged: (value) {
                        setState(() {
                          context.read<DatabaseProvider>().cambiarTema();
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
                    Text(
                      "Tamaño de la fuente",
                      style: TextStyle(
                        fontSize:
                            2 *
                            (context
                                .read<DatabaseProvider>()
                                .multiplicadorFuente),
                      ),
                    ),
                    Slider(
                      min: 5.0,
                      max: 14.0,
                      value: context
                          .read<DatabaseProvider>()
                          .multiplicadorFuente,
                      onChanged: (value) {
                        setState(() {
                          context.read<DatabaseProvider>().cambiarFuente(value);
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

  bool _modoClaro = false;

  bool get modoClaro => _modoClaro;

  double _MultiplicadorFuente = 5.0;

  double get multiplicadorFuente => _MultiplicadorFuente;

  late final Future<Database> database;
  DatabaseProvider() {
    database = _loadDatabase();
    cargarUsuarios();
    cargarDatosFuente();
    cargarDatosTema();
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
    await db.insert('usuarios', {'nombre': nombre, 'edad': edad});
    cargarUsuarios();
    notifyListeners();
  }

  Future<void> modificarEdad(String nombre, int edad) async {
    final db = await database;
    await db.update(
      'usuarios',
      {'edad': edad},
      where: 'nombre=?',
      whereArgs: [nombre],
    );
    cargarUsuarios();
    notifyListeners();
  }

  Future<void> borrarUsuario(String nombre, int edad) async {
    final db = await database;
    await db.delete(
      'usuarios',
      where: 'nombre=? AND edad=?',
      whereArgs: [nombre, edad],
    );
    cargarUsuarios();
    notifyListeners();
  }

  Future<void> cargarDatosTema() async {
    final prefs = await SharedPreferences.getInstance();
    _modoClaro = prefs.getBool('modoClaro') ?? false;
    notifyListeners();
  }

  Future<void> cambiarTema() async {
    _modoClaro = !_modoClaro;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoClaro', _modoClaro);
  }

  Future<void> cargarDatosFuente() async {
    final prefs = await SharedPreferences.getInstance();
    _MultiplicadorFuente = prefs.getDouble('multiplicador') ?? 10.0;
    notifyListeners();
  }

  Future<void> cambiarFuente(double multiplicador) async {
    _MultiplicadorFuente = multiplicador;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('multiplicador', multiplicador);
    notifyListeners();
  }
}
