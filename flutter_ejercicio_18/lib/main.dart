import 'package:flutter/material.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatefulWidget {

   MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool pulsado=false;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Checkbox(value: pulsado, onChanged: (value) {
            pulsado=true;
            print(pulsado);
          },),
        ),
      ),
    );
  }
}
