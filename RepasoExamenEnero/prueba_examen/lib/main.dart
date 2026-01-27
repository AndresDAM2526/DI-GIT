import 'package:flutter/material.dart';
import 'package:prueba_examen/view/ajustes_view.dart';
import 'package:prueba_examen/view/conversor_view.dart';

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
              DrawerHeader(child: Text("Menu")),
              ListTile(leading: Icon(Icons.compare_arrows_rounded)),
              ListTile(leading: Icon(Icons.format_line_spacing_sharp)),
              ListTile(leading: Icon(Icons.settings)),
            ],
          ),
        ),
        body: ConversorView(),
      ),
    );
  }
}
