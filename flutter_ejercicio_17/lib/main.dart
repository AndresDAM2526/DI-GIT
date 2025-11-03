import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode modoPantalla = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: modoPantalla,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                //(Condicion ? valorVerdadero :ValorFalso)
                modoPantalla = (modoPantalla == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light);
              });
            },
            child: Text("Presione para cambiar a modo oscuro"),
          ),
        ),
      ),
    );
  }
}
