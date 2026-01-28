import 'package:flutter/material.dart';

class ConversorViewmodel extends ChangeNotifier {
  final conversionRates = {
    'Kilómetros': {'Kilómetros': 1.0, 'Metros': 1000.0, 'Millas': 0.621371},
    'Metros': {'Kilómetros': 0.001, 'Metros': 1.0, 'Millas': 0.000621371},
    'Millas': {'Kilómetros': 1.60934, 'Metros': 1609.34, 'Millas': 1.0},
  };
  final valor = TextEditingController();
  final keyUnidadInicial = GlobalKey<FormState>();
  final keyUnidadFinal = GlobalKey<FormState>();


  String? validarValor(String? valor) {
    if (valor!.isEmpty || valor == null) {
      return "El campo está vacio";
    } else if (int.tryParse(valor) == null) {
      return "El formato del número es incorrecto";
    }
  }

  double realizarConversion(
    String unidadInicial,
    String unidadFinal,
    double valor,
  ) {
    double? valorConversion = conversionRates[unidadInicial]![unidadFinal];
    return valorConversion! * valor;
  }
}
