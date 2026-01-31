import 'package:flutter/material.dart';

///Clase para validar el formulario de añadir un producto
class FormularioViewmodel extends ChangeNotifier {
  String nombre = "";
  String categoria = "";
  String cantidad = "";
  String price = "";

  ///Función para validar el nombre
  String? validarNombre(String? campo) {
    if (campo!.isEmpty || campo == null) {
      return "Introduzca un nombre";
    }
  }

  ///Función para validar la categoría
  String? validarCategoria(String? campo) {
    if (campo == null) {
      return "Seleccione una categoria";
    }
  }

  ///Función para validar la cantidad
  String? validarCantidad(String? campo) {
    if (campo!.isEmpty || campo == null) {
      return "Cantidad vacia";
    } else if (int.tryParse(campo) == null) {
      return "Formato de cantidad incorrecto";
    }
  }

  ///Función para validar el precio
  String? validarPrecio(String? campo) {
    if (campo!.isEmpty || campo == null) {
      return "Precio vacio";
    } else if (double.tryParse(campo) == null) {
      return "Formato de precio incorrecto";
    }
  }
}
