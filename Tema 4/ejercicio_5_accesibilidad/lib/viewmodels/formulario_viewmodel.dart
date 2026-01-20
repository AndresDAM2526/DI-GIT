import 'package:ejercicio_5_accesibilidad/models/formulario_model.dart';
import 'package:flutter/material.dart';

class FormularioViewmodel extends ChangeNotifier {
  String nombre = "";
  String correo = "";
  String telefono = "";
  final controladorNombre = TextEditingController();
  final controladorCorreo = TextEditingController();
  final controladorTelefono = TextEditingController();

  String? validarNombre(String? valor) {
    if (valor == null || valor.isEmpty) {
      return "El valor está vacio";
    }
    //Esta bien
    return null;
  }

  String? validarCorreo(String? valor) {
    if (valor == null || valor.isEmpty) {
      return "El valor está vacio";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(valor)) {
      return "El formato del correo es incorrecto";
    }
    //Esta bien
    return null;
  }

  String? validarTelefono(String? valor) {
    if (valor == null || valor.isEmpty) {
      return "El valor está vacio";
    }
    if (valor.length != 9 || int.tryParse(valor) == null) {
      return "Formato del número incorrecto";
    }
    //Esta bien
    return null;
  }

  void limpiarFormulario() {
    controladorNombre.clear();
    controladorCorreo.clear();
    controladorTelefono.clear();
    notifyListeners();
  }

  void enviarFormulario(String nombre, String correo, String telefono) {
    final formularioModel = FormularioModel(
      nombre: nombre,
      correo: correo,
      tf: telefono,
    );
    print(formularioModel.toString());
    notifyListeners();
  }
}
