import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) =>  PantallaA(), //Para que esto funcione, debo borrar el home. Si está el home no se puede poner solo la / porque indica que hay redundancia
        '/pantallaB': (context) => PantallaB()
      },
    );
  }
}

class PantallaA extends StatelessWidget {
  const PantallaA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantalla A"), backgroundColor: Colors.amber),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Esta es la pantalla A"),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/pantallaB');
            },
            child: Text("Pantalla B"),
          ),
        ],
      ),
    );
  }
}

class PantallaB extends StatelessWidget {
  const PantallaB({super.key});

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
          Text("Esta es la pantalla B"),
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
