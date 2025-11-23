import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:lista_tareas/Tarea.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TareaProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tarea> tareas = context.watch<TareaProvider>().tareas;
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Lista de tareas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: tareas.isEmpty
                ? Center(child: Text("No hay tareas"))
                : Center(
                    child: ListView.builder(
                      itemCount: tareas.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(tareas[index].titulo),
                            subtitle: tareas[index].descripcion.isEmpty
                                ? Text("Sin descripcion")
                                : Text(tareas[index].descripcion),
                            trailing: Text(tareas[index].fecha.toString()),
                          ),
                        );
                      },
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormularioTareas()),
                );
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class FormularioTareas extends StatelessWidget {
  final validarFormulario = GlobalKey<FormState>();
  TextEditingController? titulo = TextEditingController();
  TextEditingController? descripcion = TextEditingController();
  TextEditingController? fecha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> seleccionarFecha() async {
      DateTime? fechaSeleccionada = await showDatePicker(
        context: context,
        firstDate: DateTime(
          //Primera fecha que se puede seleccionar
          2020,
          1,
          1,
        ),
        lastDate: DateTime(
          //Ultima fecha que se puede seleccionar
          2050,
          1,
          1,
        ),
      );
      if (fechaSeleccionada != null) {
        fecha!.text =
            "${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}";
      }
      return fechaSeleccionada;
    }

    DateTime parsearFecha(String fecha) {
      return DateFormat("dd/MM/yyyy").parse(fecha);
    }

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Agregar tarea "))),
      body: Form(
        key: validarFormulario,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Card(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Introduzca el titulo";
                    }
                  },
                  controller: titulo,
                  decoration: InputDecoration(
                    label: Text("Título de la tarea"),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Card(
                child: TextFormField(
                  controller: descripcion,
                  decoration: InputDecoration(
                    label: Text("Descripción de la tarea"),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Card(
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Debe introducir una fecha";
                    }
                  },
                  controller: fecha,
                  decoration: InputDecoration(label: Text("Fecha")),
                  onTap: seleccionarFecha,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (validarFormulario.currentState!.validate()) {
                  Tarea nuevaTarea = Tarea(
                    titulo: titulo!.text,
                    descripcion: descripcion!.text,
                    fecha: parsearFecha(fecha!.text),
                  );
                  context.read<TareaProvider>().anadirTarea(nuevaTarea);
                  Navigator.pop(context);
                }
              },
              child: Text("Añadir tarea"),
            ),
          ],
        ),
      ),
    );
  }
}

class TareaProvider extends ChangeNotifier {
  List<Tarea> listaTareas = [];

  List<Tarea> get tareas => listaTareas;

  void anadirTarea(Tarea tarea) {
    listaTareas.add(tarea);
    notifyListeners();
  }
}
