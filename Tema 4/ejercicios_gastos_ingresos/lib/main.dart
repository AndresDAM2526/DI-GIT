import 'package:flutter/material.dart';
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

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PantallaPrincipal());
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Página principal"))),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text("Menu "),
            ),
            ListTile(
              title: Text("Insertar datos"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Formulario()),
                );
              },
            ),
            ListTile(
              title: Text("Transacciones"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Transacciones()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text("Página principal")),
    );
  }
}

//class Formulario
//ToggleButton
//tabla transacciones

class Formulario extends StatefulWidget {
  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  List<String> tiposIngresos = ["Nómina"];
  List<String> tiposGastos = ["Alquiler", "Internet", "Comida", "Cine"];
  List<Widget> elementosToggle = [Text("Gasto"), Text("Ingreso")];
  List<bool> seleccionado = [false, false];
  String? categoriaSeleccionada;
  final validadFormulario = GlobalKey<FormState>();
  TextEditingController? dinero = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Formulario"))),
      body: Center(
        child: Form(
          key: validadFormulario,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Card(
                  child: Column(
                    children: [
                      Text("Tipo"),
                      ToggleButtons(
                        fillColor: seleccionado[0] ? Colors.red : Colors.green,
                        isSelected: seleccionado,
                        onPressed: (index) {
                          setState(() {
                            for (int i = 0; i < seleccionado.length; i++) {
                              seleccionado[i] = (i == index);
                            }
                          });
                        },
                        children: elementosToggle,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("Categoría"),
                            DropdownButtonFormField(
                              hint: seleccionado[0]
                                  ? Text("Seleccione un gasto")
                                  : Text("Seleccione un ingreso"),
                              items: seleccionado[0]
                                  ? tiposGastos.map((String gasto) {
                                      return DropdownMenuItem<String>(
                                        value: gasto,
                                        child: Text(gasto),
                                      );
                                    }).toList()
                                  : tiposIngresos.map((String gasto) {
                                      return DropdownMenuItem<String>(
                                        value: gasto,
                                        child: Text(gasto),
                                      );
                                    }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  categoriaSeleccionada = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Introduzca una cantidad";
                            }
                          },
                          decoration: InputDecoration(label: Text("Dinero")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          child: Text(
                            "Guardar",
                            style: TextStyle(
                              color: seleccionado[0]
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Transacciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Transacciones"))),
    );
  }
}

class DatabaseProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _movimientos = [];
  List<Map<String, dynamic>> get movimientos => _movimientos;

  late final Future<Database> database;

  DatabaseProvider() {
    database = _loadDatabase();
    cargarDatos();
  }

  Future<Database> _loadDatabase() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final dbPath = join(await databaseFactory.getDatabasesPath(), 'cuenta.db');
    final database = await databaseFactory.openDatabase(dbPath);
    await database.execute('''CREATE TABLE IF NOT EXISTS cuenta(
      id integer PRIMARY KEY AUTOINCREMENT,
      tipo TEXT NOT NULL,
      categoria TEXT NOT NULL,
      dinero double NOT NULL
    )''');
    return database;
  }

  Future<void> cargarDatos() async {
    final db = await database;
    _movimientos = await db.query('cuenta');
    notifyListeners();
  }

  Future<void> anadirGasto(String categoria, double dinero) async {
    final db = await database;
    await db.insert('cuenta', {
      'tipo': 'Gasto',
      'categoria': categoria,
      'dinero': dinero,
    });
  }
  Future<void> anadirIngreso(String categoria, double dinero) async {
    final db = await database;
    await db.insert('cuenta', {
      'tipo': 'Ingreso',
      'categoria': categoria,
      'dinero': dinero,
    });
  }
}
