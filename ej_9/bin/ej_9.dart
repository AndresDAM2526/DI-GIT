import 'package:logger/logger.dart';


void main() {
  List<String> tareas=[];
 
}

void anadirTarea(String tarea,List<String> tareas){
  tareas.add(tarea);
  Logger log=Logger();
  log.d("Se ha añadido la tarea");

}


