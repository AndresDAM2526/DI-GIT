import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class CsvViewmodel extends ChangeNotifier {
  Future<List<List<dynamic>>> cargarCsv(File fichero) async {
    final rutaFichero = await fichero.readAsString();
    List<List<dynamic>> datos = CsvToListConverter(
      fieldDelimiter: ",",
    ).convert(rutaFichero);
    return datos;
  }
}
