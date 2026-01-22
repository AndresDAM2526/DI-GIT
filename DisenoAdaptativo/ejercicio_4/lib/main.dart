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
  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: FocusTraversalGroup(
                  child: Column(
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text("Prueba")),
                      ElevatedButton(onPressed: () {}, child: Text("Prueba")),
                      ElevatedButton(onPressed: () {}, child: Text("Prueba")),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Text("Hola"),
                onTap: () {
                  print("Has clicado");
                },
              ),
              MouseRegion(
                onEnter: (event) {
                  setState(() {
                    color=Colors.black;
                  });
                  
                },
                child: Container(color: color, child: Text("data")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
