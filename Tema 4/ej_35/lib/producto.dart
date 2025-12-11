import 'dart:convert';

import 'package:flutter/services.dart';

class Producto{
  String nombre;
  double precio;

  Producto({required this.nombre,required this.precio});

  factory Producto.fromJson(Map<String,dynamic> json){
    return Producto(nombre: json['nombre'], precio: double.parse(json['precio']));
  }

  Future<List<Producto>> obtenerProductos() async{
    final String productos = await rootBundle.loadString("assets/datos.json");
    final List<dynamic> listaProductos =jsonDecode(productos);
    return listaProductos.map((producto) => Producto.fromJson(producto)).toList();
  }
}