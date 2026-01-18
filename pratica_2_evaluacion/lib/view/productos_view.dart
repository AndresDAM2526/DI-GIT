import 'package:flutter/material.dart';
import 'package:pratica_2_evaluacion/l10n/app_localizations.dart';
import 'package:pratica_2_evaluacion/model/producto_model.dart';
import 'package:pratica_2_evaluacion/view/anadir_productos_view.dart';
import 'package:pratica_2_evaluacion/view/modificar_producto_view.dart';
import 'package:pratica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';

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
                margin: EdgeInsets.all(4),
                child: Text(
                  productosCarrito.isEmpty
                      ? l10n.emptyCart
                      : "${l10n.notEmptyCart} : ${productosCarrito.length}",
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Semantics(
                      label:
                          "Botón para crear una factura con los productos de carrito",
                      hint: "Se procede a crear una factura",
                      child: ElevatedButton(
                        onPressed: productosCarrito.isEmpty
                            ? null
                            : () {
                                List<Producto> productos = context
                                    .read<DatabaseProvider>()
                                    .carrito;
                                context.read<DatabaseProvider>().crearFactura(
                                  productos,
                                );
                              },
                        child: Text(l10n.buy),
                      ),
                    ),
                  ),
                  Semantics(
                    label: "Botón para vaciar el carrito",
                    hint:
                        "Se procece a borrar los productos que se encuentran en el carrito",
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<DatabaseProvider>().vaciarCarrito();
                      },
                      child: Text(l10n.emptyCartAction),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Semantics(
            label:
                "Tabla en la que se muestran todos los productos disponibles en la tienda",
            hint:
                "Se visualizan todos los productos disponibles en la tienda en formato de tabla. Las columnas de la tabla son nombre, categoria,cantidad y precio del producto",
            child: DataTable(
              columns: [
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
                                      "Botón para modificar los datos de un producto",
                                  hint:
                                      "Al pulsar se redirige al usuario a otra pestaña donde se introducen los nuevos datos del producto",
                                  child: FloatingActionButton(
                                    tooltip: l10n.tableEdit,
                                    heroTag:
                                        "modificar-${producto['nombre']}", //Identificador único para la animación hero, que es la que realiza cuando se cambia de pantalla
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              modificarProducto(
                                                idProducto:
                                                    producto['idProducto'],
                                              ),
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.mode),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Semantics(
                                  label: "Botón para borrar un producto",
                                  hint:
                                      "Al pulsar se borra el producto seleccionado de la base de datos ",
                                  child: FloatingActionButton(
                                    tooltip: l10n.tabledelete,
                                    heroTag: "eliminar-${producto['nombre']}",
                                    onPressed: () {
                                      context
                                          .read<DatabaseProvider>()
                                          .borrarProducto(
                                            producto['idProducto'],
                                          );
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ),
                              ),
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
        hint: "Al pulsar, se redirige al usuario a la pestaña donde se introducen los datos del nuevo producto",
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
