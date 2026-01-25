import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
import 'package:practica_2_evaluacion/view/anadir_productos_view.dart';
import 'package:practica_2_evaluacion/view/carrito_view.dart';
import 'package:practica_2_evaluacion/view/modificar_producto_view.dart';
import 'package:practica_2_evaluacion/viewmodel/csv_viewmodel.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Productos extends StatefulWidget {
  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  int indiceCategoria = 0;
  String? botonSeleccionado;
  @override
  Widget build(BuildContext context) {
    final productos = context.watch<DatabaseProvider>().productos;
    final productosFiltrados = context
        .watch<DatabaseProvider>()
        .productosFiltrados;
    final categorias = context.watch<DatabaseProvider>().categorias;
    List<Widget> elementoToggle = categorias
        .map(
          (categoria) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(categoria["categoria"]),
          ),
        )
        .toList();
    List<bool> toggle = List.generate(
      elementoToggle.length,
      (index) => index == indiceCategoria,
    );
    final productosCarrito = context.watch<DatabaseProvider>().carrito;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.stockTitle))),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: badges.Badge(
                    badgeContent: Text("${productosCarrito.length}"),
                    child: Icon(Icons.shopping_cart),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: CarritoView(productos: productosCarrito),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            //Filtro principal->Mostrar todos, filtrar
            Container(
              margin: EdgeInsets.all(2),
              child: Column(
                children: [
                  RadioGroup(
                    onChanged: (value) {
                      setState(() {
                        botonSeleccionado = value;
                      });
                    },
                    groupValue: botonSeleccionado,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Radio(value: "Todos"),
                          title: Text("Mostrar todos"),
                        ),
                        ListTile(
                          leading: Radio(value: "Filtrar"),
                          title: Text("Filtrar"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Buscador
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) {
                  if (botonSeleccionado == "Todos") {
                    context.read<DatabaseProvider>().buscarProductosPorNombre(
                      value,
                      "Todos",
                    );
                  } else {
                    context.read<DatabaseProvider>().buscarProductosPorNombre(
                      value,
                      "Filtrar",
                    );
                  }
                },
                decoration: InputDecoration(
                  label: Text("Buscar por nombre"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: botonSeleccionado == "Filtrar"
                  ? categorias.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ToggleButtons(
                            fillColor: Colors.green,
                            isSelected: toggle,
                            onPressed: (index) {
                              setState(() {
                                indiceCategoria = index;
                                context
                                    .read<DatabaseProvider>()
                                    .filtrarProductosPorCategoria(
                                      categorias[index]['categoria'],
                                    );
                              });
                            },
                            children: elementoToggle,
                          )
                  : null,
            ),
            //Tabla de productos
            Semantics(
              label:
                  "Tabla en la que se muestran todos los productos disponibles en la tienda",
              hint:
                  "Se visualizan todos los productos disponibles en la tienda en formato de tabla. Las columnas de la tabla son nombre, categoria,cantidad y precio del producto",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: botonSeleccionado == "Todos"
                    ? DataTable(
                        columns: [
                          DataColumn(label: Text("")),
                          DataColumn(label: Text(l10n.tableName)),
                          DataColumn(label: Text(l10n.tableCategory)),
                          DataColumn(label: Text(l10n.tableQuantity)),
                          DataColumn(label: Text(l10n.tablePrice)),
                          DataColumn(label: Text("")),
                        ],
                        rows: productos
                            .map(
                              (producto) => DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: modificarProducto(
                                                    idProducto:
                                                        producto['idProducto'],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            context
                                                .read<DatabaseProvider>()
                                                .borrarProducto(
                                                  producto['idProducto'],
                                                );
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(producto['nombre'])),
                                  DataCell(Text(producto['categoria'])),
                                  DataCell(
                                    Text(producto['cantidad'].toString()),
                                  ),
                                  DataCell(Text(producto['precio'].toString())),
                                  DataCell(
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Semantics(
                                            label:
                                                "Botón para añadir un producto al carrito",
                                            hint:
                                                "Se añade el producto seleccionado al carrito",
                                            child: FloatingActionButton(
                                              tooltip: l10n.tableAddProduct,
                                              heroTag:
                                                  "anadir-${producto['nombre']}",
                                              onPressed: () async {
                                                int cantidad = await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    TextEditingController?
                                                    cantidadSeleccionada;
                                                    return AlertDialog(
                                                      title: Text("Cantidad"),
                                                      actions: [
                                                        Column(
                                                          children: [
                                                            TextField(
                                                              controller:
                                                                  cantidadSeleccionada,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                if (double.tryParse(
                                                                      cantidadSeleccionada!
                                                                          .text,
                                                                    ) !=
                                                                    null) {
                                                                  Navigator.pop(
                                                                    context,
                                                                    double.parse(
                                                                      cantidadSeleccionada
                                                                          .text,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  print(
                                                                    "Incorrecto",
                                                                  );
                                                                }
                                                              },
                                                              child: Text(
                                                                "Confirmar",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                int idProducto =
                                                    producto['idProducto'];
                                                String nombre =
                                                    producto['nombre'];
                                                String categoria =
                                                    producto['categoria'];

                                                double precio =
                                                    producto['precio'];
                                                Producto nuevoProducto =
                                                    Producto(
                                                      idProducto: idProducto,
                                                      nombre: nombre,
                                                      categoria: categoria,
                                                      cantidad: cantidad,
                                                      precio: precio,
                                                    );
                                                context
                                                    .read<DatabaseProvider>()
                                                    .anadirProductoCarrito(
                                                      nuevoProducto,
                                                    );
                                              },
                                              child: Icon(Icons.shopping_cart),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      )
                    : DataTable(
                        columns: [
                          DataColumn(label: Text("")),
                          DataColumn(label: Text(l10n.tableName)),
                          DataColumn(label: Text(l10n.tableCategory)),
                          DataColumn(label: Text(l10n.tableQuantity)),
                          DataColumn(label: Text(l10n.tablePrice)),
                          DataColumn(label: Text("")),
                        ],
                        rows: productosFiltrados
                            .map(
                              (producto) => DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: modificarProducto(
                                                    idProducto:
                                                        producto['idProducto'],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(Icons.edit),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            context
                                                .read<DatabaseProvider>()
                                                .borrarProducto(
                                                  producto['idProducto'],
                                                );
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(producto['nombre'])),
                                  DataCell(Text(producto['categoria'])),
                                  DataCell(
                                    Text(producto['cantidad'].toString()),
                                  ),
                                  DataCell(Text(producto['precio'].toString())),
                                  DataCell(
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Semantics(
                                            label:
                                                "Botón para añadir un producto al carrito",
                                            hint:
                                                "Se añade el producto seleccionado al carrito",
                                            child: FloatingActionButton(
                                              tooltip: l10n.tableAddProduct,
                                              heroTag:
                                                  "anadir-${producto['nombre']}",
                                              onPressed: () {
                                                int idProducto =
                                                    producto['idProducto'];
                                                String nombre =
                                                    producto['nombre'];
                                                String categoria =
                                                    producto['categoria'];
                                                int cantidad =
                                                    producto['cantidad'];
                                                double precio =
                                                    producto['precio'];
                                                Producto nuevoProducto =
                                                    Producto(
                                                      idProducto: idProducto,
                                                      nombre: nombre,
                                                      categoria: categoria,
                                                      cantidad: cantidad,
                                                      precio: precio,
                                                    );
                                                context
                                                    .read<DatabaseProvider>()
                                                    .anadirProductoCarrito(
                                                      nuevoProducto,
                                                    );
                                              },
                                              child: Icon(Icons.shopping_cart),
                                            ),
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
              ),
            ),
          ],
        ),
      ),
      //Botones inferiores
      floatingActionButton: Semantics(
        label: "Botón para añadir un producto a la base de datos",
        hint:
            "Al pulsar, se redirige al usuario a la pestaña donde se introducen los datos del nuevo producto",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: FloatingActionButton(
                onPressed: () async {
                  final csvViewmodel = context.read<CsvViewmodel>();
                  final databaseViewModel = context.read<DatabaseProvider>();
                  FilePickerResult? fichero = await FilePicker.platform
                      .pickFiles();
                  if (fichero != null) {
                    File file = File(fichero.files.single.path!);
                    final productosSerializados = csvViewmodel.cargarCsv(file);
                    databaseViewModel.anadirProductosCsv(productosSerializados);
                  }
                },
                child: Icon(Icons.upload),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: FloatingActionButton(
                tooltip: l10n.buttonAddProduct,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => anadirProductos()),
                  );
                },
                child: Icon(Icons.add_circle_sharp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
