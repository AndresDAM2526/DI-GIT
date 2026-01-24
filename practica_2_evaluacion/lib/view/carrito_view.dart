import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/model/producto_model.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';

class CarritoView extends StatefulWidget {
  List<Producto> productos;
  CarritoView({super.key, required this.productos});

  @override
  State<CarritoView> createState() => _CarritoViewState();
}

class _CarritoViewState extends State<CarritoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Carrito"))),
      body: widget.productos.isEmpty
          ? Center(child: Text("No hay producto actualmente en el carrito"))
          : ListView.builder(
              itemCount: widget.productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.productos[index].nombre),
                  subtitle: Text("${widget.productos[index].precio}"),
                );
              },
            ),
      floatingActionButton: widget.productos.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<DatabaseProvider>().vaciarCarrito();
                    },
                    child: Icon(Icons.delete),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<DatabaseProvider>().crearFactura(
                        widget.productos,
                      );
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
