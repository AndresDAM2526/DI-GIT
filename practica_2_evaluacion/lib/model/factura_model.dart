import 'producto_model.dart';
import 'dart:convert';
///Clase usada para generar un objeto de tipo factura
class Factura {
  ///Atributo que guarda la fecha de la factura
  DateTime fecha;
  ///Atributo que requiere una lista de productos
  List<Producto> productos;

  Factura({required this.fecha, required this.productos});

  Map<String, dynamic> toJson() => {
    'fecha': fecha.toString(),
    'productos': productos.map((producto) => producto.toJson()).toList(),
  };

}
