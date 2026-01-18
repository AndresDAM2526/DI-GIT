import 'package:flutter/material.dart';

class FormularioViewmodel extends ChangeNotifier {
  String nombre = "";
  String categoria = "";
  String cantidad = "";
  String price = "";

  String? validarNombre(String? campo) {
    if (campo!.isEmpty || campo == null) {
      return "Introduzca un nombre";
    }
  }

  String? validarCategoria(String? campo) {
    if (campo == null) {
      return "Seleccione una categoria";
    }
  }

  String? validarCantidad(String? campo) {
    if (campo!.isEmpty || campo == null) {
      return "Cantidad vacia";
    } else if (int.tryParse(campo) == null) {
      return "Formato de cantidad incorrecto";
    }
  }

  String? validadPrecio(String? campo) {
    if (campo!.isEmpty || campo == null) {
      return "Precio vacio";
    } else if (double.tryParse(campo) == null) {
      return "Formato de precio incorrecto";
    }
  }
}
