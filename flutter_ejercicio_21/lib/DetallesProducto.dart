import 'package:flutter/material.dart';
import 'package:flutter_ejercicio_21/Producto.dart';

class DetallesProducto extends StatelessWidget {
  final Producto producto;

  DetallesProducto({required this.producto});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nombre: ${producto.nombre}"),
          Text("Precio: ${producto.precio}"),
          Text("Tipo de producto: ${producto.tipo}"),
          Text("IVA: ${producto.iva}"),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Volver"),
          ),
        ],
      ),
    );
  }
}
