import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            //width: 400,
            //height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Card(
              color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Hola, que tal estás"),
              ),
            ),
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
          ),
        ),
      ),
    );
  }
}
