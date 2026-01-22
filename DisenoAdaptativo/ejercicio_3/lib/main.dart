import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return MaterialApp(home: Scaffold(body: ScaffoldCambiante()));
  }
}

class ScaffoldCambiante extends StatefulWidget {
  const ScaffoldCambiante({super.key});

  @override
  State<ScaffoldCambiante> createState() => _ScaffoldCambianteState();
}

class _ScaffoldCambianteState extends State<ScaffoldCambiante> {
  int indice = 0;
  Widget obtenerPagina(int indice) {
    switch (indice) {
      case 0:
        return HomePage();
      case 1:
        return Perfil();
      case 2:
        return Ajustes();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final anchura = MediaQuery.sizeOf(context).width;
    return Scaffold(
      bottomNavigationBar: anchura < 600
          ? NavigationBar(
              selectedIndex: indice,
              onDestinationSelected: (value) {
                setState(() {
                  indice = value;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Home",
                  selectedIcon: Icon(Icons.home_outlined),
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: "Perfil",
                  selectedIcon: Icon(Icons.person_2_outlined),
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: "Ajustes",
                  selectedIcon: Icon(Icons.settings_outlined),
                ),
              ],
            )
          : null,
      body: Row(
        children: [
          if (anchura >= 600)
            NavigationRail(
              onDestinationSelected: (value) {
                setState(() {
                  indice = value;
                });
              },
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home_outlined),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  selectedIcon: Icon(Icons.person_2_outlined),
                  label: Text("Perfil"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  selectedIcon: Icon(Icons.settings_outlined),
                  label: Text("Ajustes"),
                ),
              ],
              selectedIndex: indice,
            ),
          obtenerPagina(indice),
        ],
      ),
    );
  }
}

//Páginas
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Home");
  }
}

class Perfil extends StatelessWidget {
  Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Perfil");
  }
}

class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Ajustes");
  }
}
