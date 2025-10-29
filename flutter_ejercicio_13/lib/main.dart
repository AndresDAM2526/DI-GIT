import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text("Prueba SingleChildScrollView"),
              ),
              Container(
                margin: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "En este ejercicio se quiere comprobar si al reducir el tamaño de la pantalla todo el contenido se mueve, permitiendo verse correctamente",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Boton 1")),
                  ElevatedButton(onPressed: () {}, child: Text("Boton 1")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
