import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Text("Menu ")),
              ListTile(title: Text("Insertar datos")),
              ListTile(title: Text("Transacciones")),
            ],
          ),
        ),
        body: Center(child: Text('Hello World!')),
      ),
    );
  }
}

//class Formulario
//ToggleButton
//tabla transacciones