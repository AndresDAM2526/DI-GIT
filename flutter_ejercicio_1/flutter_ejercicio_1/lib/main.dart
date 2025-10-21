import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  initstate(){
    print("Mensaje desde initState");
  }

  dispose(){
    print("Mensaje desde dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("Mensaje desde build");
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }

  
}
