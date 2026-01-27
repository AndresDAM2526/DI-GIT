import 'package:flutter/material.dart';

class FormularioViewmodel extends ChangeNotifier {
  String nombre = "";
  int telefono = 0;
  final nombreControlador = TextEditingController();
  final telefonoControlador = TextEditingController();

  String? validarNombre(String? valor) {
    if (valor!.isEmpty) {
      return "Campo vacío";
    } else if (!RegExp('^[^0-9]').hasMatch(valor)) {
      return "Formato del nombre incorrecto";
    }
  }

  String? validarTelefono(String? valor) {
    if (valor!.isEmpty) {
      return "Campo vacío";
    } else if (valor.length != 9) {
      return "Longitud del teléfono incorrecta";
    } else if (int.tryParse(valor) == null) {
      return "Formato del número incorrecto";
    }
  }

  void vaciarCampos() {
    nombreControlador.clear();
    telefonoControlador.clear();
  }

  void enviarFormulario() {
    print("Hola");
  }
}
