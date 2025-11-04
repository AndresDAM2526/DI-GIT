import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  final pdf = pw.Document();

  print("Introduzca su nombre: ");
  String? nombre = stdin.readLineSync();
  print("Introduzca sus apellidos: ");
  String? apellidos = stdin.readLineSync();
  print("Introduzca su email: ");
  String? email = stdin.readLineSync();
  print("Introduzca su dirección: ");
  String? direccion = stdin.readLineSync();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Text("Nombre: $nombre"),
          pw.Text("apellidos: $apellidos"),
          pw.Text("email: $email"),
          pw.Text("direccion: $direccion"),
        ],
      ),
    ),
  );
  final file = File("PrimerPDF.pdf");
  await file.writeAsBytes(await pdf.save());
}
