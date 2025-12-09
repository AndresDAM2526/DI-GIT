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
    return Consumer<DatabaseProvider>(
      builder: (_, value, __) => MaterialApp(home: PantallaPrincipal()),
    );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Formulario()),
                );
              },
            ),
            ListTile(
              title: Text("Transacciones"),
              onTap: () {
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
  List<bool> tipoSeleccionado = [false, false];
  String? categoriaSeleccionada;
  final validadFormulario = GlobalKey<FormState>();
  TextEditingController? dinero = TextEditingController();
  // se crea esta variable para poder acceder a ese widget y reiniciarlo,
  //esto lo hacemos porque si seleccionabamos un elemento del dropdown y cambiabamos a otro tipo daba error
  //de esta manera, primero reiniciamos el dropdown y luego se muestra
  GlobalKey<FormFieldState> keyDropDown = GlobalKey();

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
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("Tipo"),
                            ToggleButtons(
                              fillColor: tipoSeleccionado[0]
                                  ? Colors.red
                                  : Colors.green,
                              isSelected: tipoSeleccionado,
                              onPressed: (index) {
                                setState(() {
                                  for (
                                    int i = 0;
                                    i < tipoSeleccionado.length;
                                    i++
                                  ) {
                                    tipoSeleccionado[i] = (i == index);
                                    keyDropDown.currentState!.reset();
                                  }
                                });
                              },
                              children: elementosToggle,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text("Categoría"),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (categoriaSeleccionada!.isEmpty) {
                                  "Seleccione una categoría";
                                }
                              },
                              key: keyDropDown,
                              hint: tipoSeleccionado[0]
                                  ? Text("Seleccione un gasto")
                                  : tipoSeleccionado[1]
                                  ? Text("Seleccione un ingreso")
                                  : Text("Seleccione un tipo de movimiento"),
                              items: tipoSeleccionado[0]
                                  ? tiposGastos.map((String gasto) {
                                      return DropdownMenuItem<String>(
                                        value: gasto,
                                        child: Text(gasto),
                                      );
                                    }).toList()
                                  : tiposIngresos.map((String ingreso) {
                                      return DropdownMenuItem<String>(
                                        value: ingreso,
                                        child: Text(ingreso),
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
                          controller: dinero,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Introduzca una cantidad";
                            }
                          },
                          decoration: InputDecoration(label: Text("Dinero")),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tipoSeleccionado[0]
                                ? Colors.red
                                : Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              if (validadFormulario.currentState!.validate()) {
                                context
                                    .read<DatabaseProvider>()
                                    .anadirMovimiento(
                                      tipoSeleccionado[0] ? "Gasto" : "Ingreso",
                                      categoriaSeleccionada!,
                                      double.parse(dinero!.text),
                                    );
                                dinero!.clear();
                                categoriaSeleccionada = null;
                              }
                            });
                          },
                          child: Text(
                            "Guardar",
                            style: TextStyle(color: Colors.black),
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
      body: context.watch<DatabaseProvider>().movimientos.isEmpty
          ? Center(child: Text("No hay datos aún"))
          : Center(
              child: ListView.builder(
                itemCount: context.read<DatabaseProvider>().movimientos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Card(
                      color:
                          context
                                  .read<DatabaseProvider>()
                                  .movimientos[index]['tipo'] ==
                              "Gasto"
                          ? Colors.red
                          : Colors.green,
                      child: ListTile(
                        leading:
                            context
                                    .read<DatabaseProvider>()
                                    .movimientos[index]['tipo'] ==
                                "Gasto"
                            ? Icon(Icons.arrow_downward)
                            : Icon(Icons.arrow_upward),
                        title: Text(
                          context
                              .read<DatabaseProvider>()
                              .movimientos[index]['categoria']
                              .toString(),
                        ),
                        subtitle: Text(
                          context
                              .read<DatabaseProvider>()
                              .movimientos[index]['dinero']
                              .toString(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      tipo TEXT NOT NULL,
      categoria TEXT NOT NULL,
      dinero REAL NOT NULL
    )''');
    return database;
  }

  Future<void> cargarDatos() async {
    final db = await database;
    _movimientos = await db.query('cuenta');
    notifyListeners();
  }

  Future<void> anadirMovimiento(
    String tipo,
    String categoria,
    double dinero,
  ) async {
    final db = await database;
    await db.insert('cuenta', {
      'tipo': 'Gasto',
      'categoria': categoria,
      'dinero': dinero,
    });
    cargarDatos();
    notifyListeners();
  }
}
