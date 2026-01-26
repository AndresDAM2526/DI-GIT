import 'package:flutter/material.dart';

class FormularioUsuariosViewmodel extends ChangeNotifier {
  String nombre = "";
  String direccion = "";
  DateTime? fecha;
  final nombreControlador = TextEditingController();
  final direccionControlador = TextEditingController();
  final fechaControlador = TextEditingController();

  void vaciarCampos() {
    nombreControlador.clear();
    direccionControlador.clear();
    fechaControlador.clear();
    notifyListeners();
  }

  String? validarNombre(String? valor) {
    if (valor!.isEmpty) {
      return "El campo está vacio";
    }
  }

  String? validarDireccion(String? valor) {
    if (valor!.isEmpty) {
      return "El campo está vacio";
    }
  }

  String? validarFecha(String? valor) {
    if (valor!.isEmpty) {
      return "El campo está vacío";
    } /*else {
      DateTime fecha = DateTime.parse(valor!);
      if (fecha.isAfter(DateTime.now())) {
        return "La fecha no puede ser posterior al día de hoy";
      }
    }*/
  }
}
