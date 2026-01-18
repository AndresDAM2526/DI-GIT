import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pratica_2_evaluacion/model/producto_factura_model.dart';
import 'package:pratica_2_evaluacion/model/producto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pdf/widgets.dart' as pw;

class DatabaseProvider extends ChangeNotifier {
  List<Producto> carrito = [];
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

  Future<List<ProductoFactura>> productosFactura(int idFactura) async {
    final db = await database;
    final productos = await db.rawQuery(
      'select p.nombre,p.precio FROM Producto p INNER JOIN detalle_factura df ON df.idProducto=p.idProducto INNER JOIN factura f on df.idFactura=f.idFactura WHERE f.idFactura= ? ',
      [idFactura],
    );
    return productos
        .map((producto) => ProductoFactura.fromJson(producto))
        .toList();
  }

  Future<void> generarPDF(
    Future<List<ProductoFactura>> productosFactura,
    int idFactura,
    String fecha,
  ) async {
    final productos = await productosFactura;
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            children: [
              pw.Container(child: pw.Text("Tienda de electrónica")),
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
                            child: pw.Text("${producto.precio}"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    final file = File("Factura_$idFactura.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
