import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pratica_2_evaluacion/Factura.dart';
import 'package:pratica_2_evaluacion/Producto.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
    final productos = context.watch<DatabaseProvider>().productos;
    final productosCarrito = context.watch<DatabaseProvider>().carrito;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Inventario"))),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(4),
                child: Text(
                  productosCarrito.isEmpty
                      ? "No hay productos en el carrito"
                      : "Productos en el carrito: ${productosCarrito.length}",
                ),
              ),
              Container(
                margin: EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    List<Producto> productos = context
                        .read<DatabaseProvider>()
                        .carrito;
                    context.read<DatabaseProvider>().crearFactura(productos);
                  },
                  child: Text("Realizar compra"),
                ),
              ),
            ],
          ),
          DataTable(
            columns: [
              DataColumn(label: Text("Nombre")),
              DataColumn(label: Text("Categoria")),
              DataColumn(label: Text("Cantidad")),
              DataColumn(label: Text("Precio")),
              DataColumn(label: Text("")),
            ],
            rows: productos
                .map(
                  (producto) => DataRow(
                    cells: [
                      DataCell(Text(producto['nombre'])),
                      DataCell(Text(producto['categoria'])),
                      DataCell(Text(producto['cantidad'].toString())),
                      DataCell(Text(producto['precio'].toString())),
                      DataCell(
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: FloatingActionButton(
                                heroTag:
                                    "modificar-${producto['nombre']}", //Identificador único para la animación hero, que es la que realiza cuando se cambia de pantalla
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => modificarProducto(
                                        idProducto: producto['idProducto'],
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.mode),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: FloatingActionButton(
                                heroTag: "eliminar-${producto['nombre']}",
                                onPressed: () {
                                  context
                                      .read<DatabaseProvider>()
                                      .borrarProducto(producto['idProducto']);
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: FloatingActionButton(
                                tooltip: "Añadir al carrito",
                                onPressed: () {
                                  int idProducto = producto['idProducto'];
                                  String nombre = producto['nombre'];
                                  String categoria = producto['categoria'];
                                  int cantidad = producto['cantidad'];
                                  double precio = producto['precio'];
                                  Producto nuevoProducto = Producto(
                                    idProducto: idProducto,
                                    nombre: nombre,
                                    categoria: categoria,
                                    cantidad: cantidad,
                                    precio: precio,
                                  );
                                  context
                                      .read<DatabaseProvider>()
                                      .anadirProductoCarrito(nuevoProducto);
                                },
                                child: Icon(Icons.shopping_cart),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Añadir producto",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => anadirProductos()),
          );
        },
        child: Icon(Icons.add_circle_sharp),
      ),
    );
  }
}

class Facturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Facturas"))),
      body: FutureBuilder(
        future: context.read<DatabaseProvider>().obtenerFacturas(),
        builder: (context, snapshot) {
          final facturas = snapshot.data!;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final factura = facturas[index];
              return Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: ListTile(
                    leading: Text(factura['idFactura'].toString()),
                    title: Text(factura['fecha']),
                    subtitle: Text(factura['total'].toString()),
                    trailing: Text("Generar pdf"),
                  ),
                ),
              );
            },
          );
        },
      ),
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
  late Future<List<String>> categorias;
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorCantidad = TextEditingController();
  TextEditingController controladorPrecio = TextEditingController();
  final validadFormulario = GlobalKey<FormState>();
  String? categoriaSeleccionada;

  @override
  Widget build(BuildContext context) {
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
                      controller: controladorNombre,
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
                          validator: (value) {
                            if (value == null) {
                              return "Categoría no seleccionada";
                            }
                          },
                          hint: Text("Seleccione una categoria"),
                          items: categorias
                              .map(
                                (categoria) => DropdownMenuItem(
                                  value: categoria,
                                  child: Text(categoria),
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
                      controller: controladorCantidad,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Introduzca la cantidad";
                        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
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
                      controller: controladorPrecio,
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
                    if (validadFormulario.currentState!.validate()) {
                      Producto nuevoProducto = Producto(
                        idProducto: 0,
                        nombre: controladorNombre.text,
                        categoria: categoriaSeleccionada!,
                        cantidad: int.parse(controladorCantidad.text),
                        precio: double.parse(controladorPrecio.text),
                      );
                      context.read<DatabaseProvider>().anadirProducto(
                        nuevoProducto,
                      );
                      Navigator.pop(context);
                    }
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

class modificarProducto extends StatefulWidget {
  int idProducto;
  modificarProducto({required this.idProducto});
  @override
  State<modificarProducto> createState() => _modificarProductoState();
}

class _modificarProductoState extends State<modificarProducto> {
  final validarFormulario = GlobalKey<FormState>();
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorCantidad = TextEditingController();
  TextEditingController controladorPrecio = TextEditingController();
  GlobalKey<FormFieldState> keyDropDown = GlobalKey();
  late Future<List<String>> categorias;
  String? categoriaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Modificar producto"))),
      body: Form(
        key: validarFormulario,
        child: Column(
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controladorNombre,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Introduzca un nombre";
                    }
                  },
                  decoration: InputDecoration(label: Text("Nombre")),
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: context.read<DatabaseProvider>().cargarCategorias(),
                  builder: (context, snapshot) {
                    final categorias = snapshot.data!;
                    return DropdownButtonFormField(
                      key: keyDropDown,
                      validator: (value) {
                        if (value == null) {
                          return "Categoria no seleccionada";
                        }
                      },
                      hint: Text("Seleccione una categoria"),
                      items: categorias
                          .map(
                            (categoria) => DropdownMenuItem(
                              value: categoria,
                              child: Text(categoria),
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
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controladorCantidad,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Introduzca la cantidad";
                    } else if (int.tryParse(value) == null) {
                      return "El formato introducido es incorrecto";
                    }
                  },
                  decoration: InputDecoration(label: Text("Cantidad")),
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controladorPrecio,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Precio no introducido";
                    } else if (double.tryParse(value) == null) {
                      return "El formato introducido es incorrecto";
                    }
                  },
                  decoration: InputDecoration(label: Text("Precio")),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (validarFormulario.currentState!.validate()) {
                        Producto productoModificado = Producto(
                          idProducto: 0,
                          nombre: controladorNombre.text,
                          categoria: categoriaSeleccionada!,
                          cantidad: int.parse(controladorCantidad.text),
                          precio: double.parse(controladorPrecio.text),
                        );
                        context.read<DatabaseProvider>().modificarProducto(
                          widget.idProducto,
                          productoModificado,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Modificar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controladorNombre.clear();
                      controladorCantidad.clear();
                      controladorPrecio.clear();
                      keyDropDown.currentState!.reset();
                    },
                    child: Text("Limpiar campos"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseProvider extends ChangeNotifier {
  List<Producto> carrito = [];
  List<Factura> facturas = [];
  List<Map<String, dynamic>> _productos = [];
  List<Map<String, dynamic>> get productos => _productos;
  List<Map<String, dynamic>> _categorias = [];
  List<Map<String, dynamic>> get categorias => _categorias;
  late final Future<Database> database;

  DatabaseProvider() {
    database = _loadDatabase();
    cargarProductos();
    obtenerDatosCarrito();
  }

  //Función para poder convertir el carrito(List<Producto>) a List<String> para poder guardarlo en el SharedPreferences
  List<String> convertirCarrito(List<Producto> productos) {
    //jsonEncode convierte un objeto que está en formato json a un objeto en formato String, luego lo convierto a una lista
    return productos.map((producto) => jsonEncode(producto.toJson())).toList();
  }

  void anadirProductoCarrito(Producto producto) async {
    carrito.add(producto);
    List<String> carritoSerializado = convertirCarrito(carrito);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrito', carritoSerializado);
  }

  void guardarDatosCarrito(List<String> carritoSerializado) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrito', carritoSerializado);
  }

  Future<void> obtenerDatosCarrito() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? carritoSerializado = prefs.getStringList('carrito');
    carrito = carritoSerializado!
        .map((producto) => Producto.fromJson(jsonDecode(producto)))
        .toList();
  }

  void vaciarCarrito() async {
    carrito.clear();
    List<String> carritoSerializado = convertirCarrito(carrito);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('carrito', carritoSerializado);
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
          await db.execute('''CREATE TABLE IF NOT EXISTS factura(
                          idFactura INTEGER PRIMARY KEY AUTOINCREMENT,
                          fecha TEXT NOT NULL,
                          total REAL NOT NULL
                    )''');
          await db.execute('''CREATE TABLE IF NOT EXISTS detalle_factura(
                          idDetalle INTEGER PRIMARY KEY AUTOINCREMENT,
                          idFactura INTEGER,
                          idProducto INTEGER,

                          FOREIGN KEY(idFactura) references factura(idFactura) ON DELETE CASCADE ON UPDATE CASCADE,
                          FOREIGN KEY(idProducto) references producto(idProducto) ON DELETE CASCADE ON UPDATE CASCADE
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
    int idCategoria = await obtenerIdCategoria(producto.categoria);
    await db.insert('producto', {
      'nombre': producto.nombre,
      'idCategoria': idCategoria,
      'cantidad': producto.cantidad,
      'precio': producto.precio,
    });
    cargarProductos();
    notifyListeners();
  }

  Future<List<String>> cargarCategorias() async {
    final db = await database;
    _categorias = await db.query('categoria', columns: ['categoria']);
    return _categorias
        .map((categoria) => categoria['categoria'].toString())
        .toList();
  }

  Future<void> cargarProductos() async {
    final db = await database;
    _productos = await db.rawQuery(
      'SELECT p.idProducto,p.nombre,c.categoria as categoria,p.cantidad,p.precio FROM producto p INNER JOIN categoria c ON c.idCategoria=p.idCategoria',
    );
    notifyListeners();
  }

  Future<int> obtenerIdCategoria(String categoria) async {
    final db = await database;
    final List<Map<String, dynamic>> resultado = await db.query(
      'categoria',
      columns: ['idCategoria'],
      where: 'categoria=?',
      whereArgs: [categoria],
    );
    return resultado.first['idCategoria'];
  }

  Future<String> obtenerCategoria(int idCategoria) async {
    final db = await database;
    final List<Map<String, dynamic>> resultado = await db.query(
      'categoria',
      columns: ['categoria'],
      where: 'idCategoria=?',
      whereArgs: [idCategoria],
    );
    return resultado.first['categoria'];
  }

  Future<void> borrarProducto(int idProducto) async {
    final db = await database;
    await db.delete('producto', where: 'idProducto=?', whereArgs: [idProducto]);
    cargarProductos();
    notifyListeners();
  }

  Future<void> modificarProducto(int idProducto, Producto producto) async {
    int categoria = await obtenerIdCategoria(producto.categoria);
    final db = await database;
    await db.update(
      'producto',
      {
        'nombre': producto.nombre,
        'idcategoria': categoria,
        'cantidad': producto.cantidad,
        'precio': producto.precio,
      },
      where: 'idProducto=?',
      whereArgs: [idProducto],
    );
    cargarProductos();
    notifyListeners();
  }

  Future<void> crearFactura(List<Producto> productos) async {
    final db = await database;
    DateTime fechaActual = DateTime.now();
    DateFormat formatoFecha = DateFormat('dd/MM/yyyy');
    String fechaFormateada = formatoFecha.format(fechaActual);
    double total = calcularCosteTotalCarrito(productos);
    int idFactura = await db.insert('factura', {
      'fecha': fechaFormateada,
      'total': total,
    });
    for (Producto prod in productos) {
      await db.insert('detalle_factura', {
        'idFactura': idFactura,
        'idProducto': prod.idProducto,
      });
    }
    notifyListeners();
    vaciarCarrito();
  }

  double calcularCosteTotalCarrito(List<Producto> productos) {
    double total = 0.0;
    productos.forEach((producto) => total += producto.precio);
    return total;
  }

  Future<List<Map<String, dynamic>>> obtenerFacturas() async {
    final db = await database;
    return db.query('factura');
  }
}
