import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final tareas = context.watch<TaskProvider>().tarea;
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Center(child: Text("Lista tareas"))),
            body: tareas.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Text("Lista tareas"),
                        Text("No hay tareas"),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Formulario(),
                              ),
                            );
                          },
                          child: Text("Nueva tarea"),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Text("Lista tareas"),
                        Text(tareas),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Formulario(),
                              ),
                            );
                          },
                          child: Text("Nueva tarea"),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  TextEditingController? tarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario")),
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: tarea,
                decoration: InputDecoration(label: Text("Nueva tarea")),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, tarea);
                  context.read<TaskProvider>().anadirTarea(tarea!.text);
                },
                child: Text("Añadir tarea"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskProvider extends ChangeNotifier {
  String _tarea = "";
  String get tarea => _tarea;

  void anadirTarea(String tarea) {
    _tarea += "$tarea ";
    notifyListeners();
  }
}
