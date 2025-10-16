import 'dart:convert';
import 'dart:io';

void main() async{
  /*

  En Windows no se puede comprobar si un fichero se ha modificado, solo se puede ver si se ha cambiado un directorio
  final fichero=File("Prueba.txt");
  fichero.watch().listen((evento){
    if(evento.type==FileSystemEvent.modify){
      print("El fichero ha sido modificado");
    }
  });*/
  var fichero=File("Prueba.txt");
  var directory=fichero.parent;
  directory.watch().listen((evento){
    switch(evento.type){
      case FileSystemEvent.create:{ 
        print("Se ha creado un fichero: ${evento.path}");
        break;
        }
      case FileSystemEvent.delete:{
        print("Se ha borrado el fichero: ${evento.path}");
        break;
      }
      case FileSystemEvent.modify:{
        print("Se ha modificado el ficheor: ${evento.path}");
        break;
      }
    }
  });
  /*
  Stream<String> lineas= fichero.openRead()
    .transform(utf8.decoder)
    .transform(LineSplitter());

  lineas.listen(
    (linea){
      print("Procesando linea: $linea");
    }
  );
  */
}
