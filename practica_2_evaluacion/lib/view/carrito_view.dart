import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:practica_2_evaluacion/widgets/card_producto_carrito_widget.dart';
import 'package:provider/provider.dart';

class CarritoView extends StatefulWidget {
  CarritoView({super.key});

  @override
  State<CarritoView> createState() => _CarritoViewState();
}

class _CarritoViewState extends State<CarritoView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final productos = context.watch<DatabaseProvider>().carrito;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.cart))),
      body: productos.isEmpty
          ? Center(child: Text(l10n.emptyCart))
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return CardProductoCarritoWidget(
                  producto: producto,
                  borrar: () {
                    setState(() {
                      context.read<DatabaseProvider>().borrarProductoCarrito(
                        producto.idProducto,
                      );
                    });
                  },
                );
              },
            ),
      floatingActionButton: productos.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    tooltip: "Vaciar carrito",
                    onPressed: () {
                      context.read<DatabaseProvider>().vaciarCarrito();
                    },
                    child: Icon(Icons.delete),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    tooltip: "Pagar carrito",
                    onPressed: () {
                      context.read<DatabaseProvider>().crearFactura(productos);
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.credit_card),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
