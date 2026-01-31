import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:practica_2_evaluacion/model/producto_csv.dart';
import 'package:practica_2_evaluacion/model/producto_factura_model.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pdf/widgets.dart' as pw;

///Clase que gestiona las operaciones relacionadaa con la base de datos
class DatabaseProvider extends ChangeNotifier {
  ///Variable que guarda los productos del carrito
  List<Producto> carrito = [];
  List<Map<String, dynamic>> _productos = [];

  ///Variable que almacena todos los productos de la base de datos
  List<Map<String, dynamic>> get productos => _productos;
  List<Map<String, dynamic>> _categorias = [];

  ///Variable que almacena todas las categorias de productos
  List<Map<String, dynamic>> get categorias => _categorias;

  ///Variable usada para mostrar los productos en función de un filtro
  List<Map<String, dynamic>> _productosFiltrados = [];

  ///Variable usada para mostrar los productos en función de un filtro
  List<Map<String, dynamic>> get productosFiltrados => _productosFiltrados;
  late final Future<Database> database;

  ///Contructor
  DatabaseProvider() {
    database = _loadDatabase();
    cargarProductos();
    cargarCategorias();
    obtenerDatosCarrito();
  }

  //Función para poder convertir el carrito(List<Producto>) a List<String> para poder guardarlo en el SharedPreferences
  ///Función que convierto una lista de Productos en una lista de String para poder guardarlos en SharedPreferences
  List<String> convertirCarrito(List<Producto> productos) {
    //jsonEncode convierte un objeto que está en formato json a un objeto en formato String, luego lo convierto a una lista
    return productos.map((producto) => jsonEncode(producto.toJson())).toList();
  }

  ///Función para añadir un producto al carrito
  void anadirProductoCarrito(Producto producto) async {
    carrito.add(producto);
    List<String> carritoSerializado = convertirCarrito(carrito);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrito', carritoSerializado);
  }

  ///Función para guardar los datos del carrito en SharedPreferences
  void guardarDatosCarrito(List<String> carritoSerializado) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrito', carritoSerializado);
  }

  ///Función para cargar los datos del carrito de SharedPreferences
  Future<void> obtenerDatosCarrito() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? carritoSerializado = prefs.getStringList('carrito');
    carrito = carritoSerializado!
        .map((producto) => Producto.fromJson(jsonDecode(producto)))
        .toList();
  }

  ///Función para borrar un producto del carrito, recibe el identificador del producto
  void borrarProductoCarrito(int idPrducto) async {
    carrito.removeWhere((producto) => producto.idProducto == idPrducto);
    notifyListeners();
    List<String> carritoSerializado = convertirCarrito(carrito);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrito', carritoSerializado);
  }

  ///Función para borrar todos los productos del carrito
  void vaciarCarrito() async {
    carrito.clear();
    List<String> carritoSerializado = convertirCarrito(carrito);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('carrito', carritoSerializado);
  }

  ///Función para crear la base de datos
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
                          cantidad INTEGER,
                          precio REAL,

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

  ///Función para añadir un producto a la base de datos
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

  ///Función usada para añadir un producto que proviene de un fichero CSV a la base de datos
  Future<void> anadirProductoCsv(ProductoCsv productoCsv) async {
    final db = await database;
    int idCategoria = await obtenerIdCategoria(productoCsv.categoria);
    await db.insert('producto', {
      'nombre': productoCsv.nombre,
      'idCategoria': idCategoria,
      'cantidad': productoCsv.cantidad,
      'precio': productoCsv.precio,
    });
    cargarProductos();
    notifyListeners();
  }

  ///Función para añadir una lista de productos que proviene de un fichero CSV a la base de datos
  void anadirProductosCsv(Future<List<List<dynamic>>> datos) async {
    final productos = await datos;
    for (int i = 1; i < productos.length; i++) {
      final fila = productos[i];
      ProductoCsv productoCsv = ProductoCsv(
        nombre: fila[0],
        categoria: fila[1],
        cantidad: fila[2],
        precio: fila[3],
      );
      anadirProductoCsv(productoCsv);
    }
  }

  ///Función que devuelve una lista de String con las categorías
  Future<List<String>> mostrarCategorias() async {
    final db = await database;
    _categorias = await db.query('categoria', columns: ['categoria']);
    notifyListeners();
    return _categorias
        .map((categoria) => categoria['categoria'].toString())
        .toList();
  }

  ///Función que cargar todas las categorias
  Future<void> cargarCategorias() async {
    final db = await database;
    _categorias = await db.query('categoria', columns: ['categoria']);
    notifyListeners();
  }

  //Función que devuelve una lista de productos un función de un filtro
  Future<void> buscarProductosPorNombre(
    String nombre,
    String opcionsSeleccionada,
  ) async {
    final db = await database;
    if (opcionsSeleccionada == "Todos") {
      _productos = await db.rawQuery(
        'SELECT p.idProducto,p.nombre,c.categoria as categoria,p.cantidad,p.precio FROM producto p INNER JOIN categoria c ON c.idCategoria=p.idCategoria WHERE p.nombre LIKE ?',
        ['%$nombre%'],
      );
    } else {
      _productosFiltrados = await db.rawQuery(
        'SELECT p.idProducto,p.nombre,c.categoria as categoria,p.cantidad,p.precio FROM producto p INNER JOIN categoria c ON c.idCategoria=p.idCategoria WHERE p.nombre LIKE ?',
        ['%$nombre%'],
      );
    }

    notifyListeners();
  }

  ///Función que carga todos los productos de la base de datos
  Future<void> cargarProductos() async {
    final db = await database;
    _productos = await db.rawQuery(
      'SELECT p.idProducto,p.nombre,c.categoria as categoria,p.cantidad,p.precio FROM producto p INNER JOIN categoria c ON c.idCategoria=p.idCategoria',
    );
    notifyListeners();
  }

  ///Función que devuelve una lista de productos que pertenecen a una categoría en concreto
  Future<void> filtrarProductosPorCategoria(String categoria) async {
    final db = await database;
    _productosFiltrados = await db.rawQuery(
      'SELECT p.idProducto,p.nombre,c.categoria as categoria,p.cantidad,p.precio FROM producto p INNER JOIN categoria c ON c.idCategoria=p.idCategoria WHERE c.categoria=?',
      [categoria],
    );
    notifyListeners();
  }

  ///Función usada para obtener el identificador de una cateogoría a partir del nombre
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

  ///Función usada para obtener el nombre de una categoría a partir del identificador
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

  ///Función para borrar un producto de la base de datos. La función recibe el identificador del producto
  Future<void> borrarProducto(int idProducto) async {
    final db = await database;
    await db.delete('producto', where: 'idProducto=?', whereArgs: [idProducto]);
    cargarProductos();
    notifyListeners();
  }

  ///Función para modificar un producto. La función recibe el identificador del producto y un objeto de tipo producto
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

  //Función que crea un registro en la tabla factura y detalle_factura. La función recibe una lista de objetos producto
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
        'cantidad': prod.cantidad,
        'precio': prod.precio,
      });
    }
    vaciarCarrito();
    notifyListeners();
    
  }

  ///Función que calcula el coste del carrito
  double calcularCosteTotalCarrito(List<Producto> productos) {
    double total = 0.0;
    productos.forEach((producto) => total += producto.precio);
    return total;
  }

  ///Función que devuelve todos los registros de la tabla factura
  Future<List<Map<String, dynamic>>> obtenerFacturas() async {
    final db = await database;
    return db.query('factura');
  }

  ///Función que devuelve los datos de una factura
  Future<List<ProductoFactura>> productosFactura(int idFactura) async {
    final db = await database;
    final productos = await db.rawQuery(
      'SELECT p.nombre,df.cantidad,df.precio FROM detalle_factura df INNER JOIN producto p ON p.idProducto=df.idProducto WHERE df.idFactura=?',
      [idFactura],
    );
    return productos
        .map((producto) => ProductoFactura.fromJson(producto))
        .toList();
  }

  ///Función para comprobar si un producto está en el carrito. Recibe un identificador de producto
  bool existeProducto(int idProducto) {
    return carrito.any((producto) => producto.idProducto == idProducto);
  }

  ///Función usada para actualizar la cantidad de producto dentro del carrito. Esta función se ejecuta cuando el usuario intenta añadir un producto que ya estaba en el carrito
  Future<void> actualizarCantidad(int idProducto, int nuevaCantidad) async {
    int index = carrito.indexWhere(
      (producto) => producto.idProducto == idProducto,
    );
    carrito[index].cantidad += nuevaCantidad;
    notifyListeners();
    List<String> carritoSerializado = convertirCarrito(carrito);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('carrito', carritoSerializado);
  }

  ///Función que actualiza la cantidad de un producto después de que ha pagado el carrito
  Future<void> actualizarCantidadBBDD(
    int idProducto,
    int cantidadComprada,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> cantidad = await db.query(
      'producto',
      where: 'idProducto=?',
      whereArgs: [idProducto],
      columns: ['cantidad'],
    );
    int cantidadActual = cantidad.first['cantidad'];
    int cantidadFinal = cantidadActual - cantidadComprada;
    await db.update(
      'producto',
      {'cantidad': cantidadFinal},
      where: 'idProducto=?',
      whereArgs: [idProducto],
    );
    cargarProductos();
    notifyListeners();
  }

  ///Función que comprueba si la cantidad que ha elegido el usuario está disponible
  Future<bool> comprobarStock(int idProducto, int cantidadComprada) async {
    final db = await database;
    final List<Map<String, dynamic>> cantidad = await db.query(
      'producto',
      where: 'idProducto=?',
      whereArgs: [idProducto],
      columns: ['cantidad'],
    );
    int stock = cantidad.first['cantidad'];
    return cantidadComprada < stock;
  }

  ///Función que genera el PDF con los datos de la factura
  Future<void> generarPDF(
    Future<List<ProductoFactura>> productosFactura,
    int idFactura,
    String fecha,
    double total,
  ) async {
    final productos = await productosFactura;
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                "Tienda de electrónica",
                style: pw.TextStyle(fontSize: 24),
              ),
            ),
            pw.Container(
              child: pw.Column(
                children: [
                  pw.Text("Identificador de factura: $idFactura"),
                  pw.Text("Fecha: $fecha"),
                ],
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.all(20),
              child: pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text("Producto"),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text("Cantidad"),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text("Precio"),
                      ),
                    ],
                  ),
                  ...productos.map(
                    (producto) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(producto.nombre),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text("${producto.cantidad}"),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text("${producto.precio}"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(10),
              child: pw.Container(child: pw.Text("Total: $total")),
            ),
          ];
        },
      ),
    );

    final file = File("Factura_$idFactura.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
