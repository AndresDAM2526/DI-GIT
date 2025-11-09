import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  List<Widget> paginas=[PantallaPrincipal(),Perfil(),Ajustes()];
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Pantalla principal"),
                Tab(text: "Perfil",),
                Tab(text: "Ajustes",),
              ],
            ),
            title: Text('App con TabBar'),
          ),
          body: TabBarView(
            children: [
              PantallaPrincipal(),
              Perfil(),
              Ajustes()
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Pagina principal")));
  }
}

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Perfil")));
  }
}

class Ajustes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Ajustes")));
  }
}
