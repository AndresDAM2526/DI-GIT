import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hola Mundo App- Windows",
            style: TextStyle(fontSize: 36),
          ),
          backgroundColor: Colors.blue,
        ),
        body:Container(color:Colors.red, child: Row(children: [])); 
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(color: Colors.red,child: Text("3"),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(color: Colors.red,child: Text("4"),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
