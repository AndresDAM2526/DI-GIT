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
        body: Column(
          children: [
            SizedBox(child: Text("Prueba 1")),
            SizedBox(child: Text("Prueba 2")),
            SizedBox(child: Text("Prueba 3")),
            SizedBox(child: ElevatedButton(onPressed: (){print("Ha pulsado el texto");}, child: Text("Pulse el botón")),)
          ],
        ),
      ),
    );
  }
}
