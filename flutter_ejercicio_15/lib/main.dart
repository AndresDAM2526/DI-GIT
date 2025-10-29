import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String nombre = "";
  final controlador = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 600,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: BoxBorder.all(color: Colors.red),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 100,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.network("https://placehold.co/600x400.png"),
                  ),
                ),
                Positioned(top: 100, left: 200, child: Text("Nombre $nombre")),
              ],
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: TextField(
                controller: controlador,
                decoration: InputDecoration(
                  labelText: "Escribe el nombre de usuario",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      nombre=controlador.text;
                    });
                  },
                  child: Text("enviar"),
                ),
                ElevatedButton(
              onPressed: () {
                setState(() {
                  nombre="";
                  controlador.clear();
                  
                });
              },
              child: Text("Restablecer"),
            ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
