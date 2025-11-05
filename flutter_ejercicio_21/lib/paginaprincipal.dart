import 'package:flutter/material.dart';
import 'package:flutter_ejercicio_21/DetallesProducto.dart';
import 'package:flutter_ejercicio_21/Producto.dart';

class Paginaprincipal extends StatelessWidget {
  Paginaprincipal({super.key});

  @override
  Widget build(BuildContext context) {
    Producto p1 = Producto("Ordenador", 1200, "Tecnología", 4);
    return Column(
      children: [
        Text(p1.nombre),
        Text("${p1.precio}"),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetallesProducto(producto: p1),
              ),
            );
          },
          child: Text("Detalles del producto"),
        ),
      ],
    );
  }
}
