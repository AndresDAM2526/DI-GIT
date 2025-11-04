import 'dart:io';
import 'package:csv/csv.dart';

void main() async {
  int sumNotas = 0;
  final file = File('assets/Libro1.csv');
  final csvString = await file.readAsString();
  List<List<dynamic>> csv = const CsvToListConverter(
    fieldDelimiter: ';',
  ).convert(csvString);

  for (var row in csv.skip(1)) {
    sumNotas += int.parse(row[2].toString());
  }
  print(sumNotas);
}
