import 'package:flutter/material.dart';

class FormularioViewmodel extends ChangeNotifier {
  String titulo = "";
  String autor = "";
  String genero = "";

  String? validarTitulo(String? valor) {
    if (valor!.isEmpty) {
      return "El campo está vacío";
    }
  }

  String? validarAutor(String? valor) {
    if (valor!.isEmpty) {
      return "El campo está vacío";
    }
  }

  String? validarGenero(String? valor) {
    if (valor == null) {
      return "El campo está vacío";
    }
  }
}
