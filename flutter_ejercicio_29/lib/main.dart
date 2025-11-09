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
  bool pulsado = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: pulsado ? Colors.red : Colors.blue,
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                pulsado = !pulsado;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: pulsado ? Colors.blue : Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(200),
            ),
          ),
        ),
      ),
    );
  }
}
