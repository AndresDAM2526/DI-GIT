import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool estadoSwitch = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: estadoSwitch ? ThemeMode.light : ThemeMode.light,
      theme: ThemeData.light(),
      home: Column(
        children: [
          Text("Pantalla Principal"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Configuration()),
              );
            },
            child: Text("Configuracion"),
          ),
        ],
      ),
    );
  }
}

class Configuration extends StatefulWidget {
  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  bool estadoSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Volver"),
          ),
          Switch(
            value: estadoSwitch,
            onChanged: (estado) {
              setState(() {
                estadoSwitch = estado;
              });
            },
          ),
        ],
      ),
    );
  }
}
