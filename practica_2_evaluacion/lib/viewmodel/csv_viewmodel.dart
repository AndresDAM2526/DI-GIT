import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

/// Clase que gestiona la carga de los ficheros de los fichero **CSV**
class CsvViewmodel extends ChangeNotifier {
  ///Función que recibe un fichero, extrae los datos y devuelve una lista
  Future<List<List<dynamic>>> cargarCsv(File fichero) async {
    final rutaFichero = await fichero.readAsString();
    List<List<dynamic>> datos = CsvToListConverter(
      fieldDelimiter: ",",
    ).convert(rutaFichero);
    return datos;
  }
}
