import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PantallaA());
  }
}

class PantallaA extends StatefulWidget {

  PantallaA({super.key});

  @override
  State<PantallaA> createState() => _PantallaAState();
}

class _PantallaAState extends State<PantallaA> {
  TextEditingController? controlador = TextEditingController();

  String nombre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla A"), backgroundColor: Colors.amber),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaB(nombre: nombre),
                ),
              );
            },
            child: Text("Pantalla B"),
          ),
        ],
      ),
    );
  }
}

class PantallaB extends StatefulWidget {
  final String nombre;
  PantallaB({super.key, required this.nombre});

  @override
  State<PantallaB> createState() => _PantallaBState();
}

class _PantallaBState extends State<PantallaB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Esta es la pantalla B"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hola"),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Pantalla A"),
          ),
        ],
      ),
    );
  }
}
