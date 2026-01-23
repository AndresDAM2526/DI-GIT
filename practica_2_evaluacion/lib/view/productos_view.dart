import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
import 'package:practica_2_evaluacion/view/anadir_productos_view.dart';
import 'package:practica_2_evaluacion/view/carrito_view.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Productos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productos = context.watch<DatabaseProvider>().productos;
    final productosCarrito = context.watch<DatabaseProvider>().carrito;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.stockTitle))),
      body: Column(
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
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              onSubmitted: (value) {
                context.read<DatabaseProvider>().buscarProductosPorNombre(
                  value,
                );
              },
              decoration: InputDecoration(
                label: Text("Buscar por nombre"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Semantics(
            label:
                "Tabla en la que se muestran todos los productos disponibles en la tienda",
            hint:
                "Se visualizan todos los productos disponibles en la tienda en formato de tabla. Las columnas de la tabla son nombre, categoria,cantidad y precio del producto",
            child: DataTable(
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
                                      return Dialog(child: anadirProductos());
                                    },
                                  );
                                },
                                child: Icon(Icons.edit),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  context
                                      .read<DatabaseProvider>()
                                      .borrarProducto(producto['idProducto']);
                                },
                                child: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(producto['nombre'])),
                        DataCell(Text(producto['categoria'])),
                        DataCell(Text(producto['cantidad'].toString())),
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
                                    heroTag: "anadir-${producto['nombre']}",
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
        ],
      ),
      floatingActionButton: Semantics(
        label: "Botón para añadir un producto a la base de datos",
        hint:
            "Al pulsar, se redirige al usuario a la pestaña donde se introducen los datos del nuevo producto",
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
    );
  }
}
