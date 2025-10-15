import 'dart:convert';
import 'dart:io';

void main() async{
  final fichero=File("Prueba.txt");
  Stream<String> lineas= fichero.openRead()
    .transform(utf8.decoder)
    .transform(LineSplitter());

  await for(String linea in lineas){
    print(linea);
  }
}
