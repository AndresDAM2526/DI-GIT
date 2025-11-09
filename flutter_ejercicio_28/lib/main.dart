import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int indicePagina = 0;

  final List<Widget> paginas = [PantallaPrincipal(), Perfil(), Ajustes()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: indicePagina,
          onTap: (value) {
            setState(() {
              indicePagina = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.key), label: 'Perfil'),
            BottomNavigationBarItem(icon: Icon(Icons.key), label: 'Ajustes'),
          ],
        ),
        body: paginas[indicePagina],
      ),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Pagina principal"));
  }
}

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Perfil"));
  }
}

class Ajustes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Ajustes"));
  }
}
