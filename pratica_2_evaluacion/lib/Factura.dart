import 'Producto.dart';
import 'dart:convert';

class Factura {
  DateTime fecha;
  List<Producto> productos;

  Factura({required this.fecha, required this.productos});

  Map<String, dynamic> toJson() => {
    'fecha': fecha.toString(),
    'productos': productos.map((producto) => producto.toJson()).toList(),
  };

}
