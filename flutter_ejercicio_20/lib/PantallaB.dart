import 'package:flutter/material.dart';

class PantallaB extends StatelessWidget {
  const PantallaB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Esta es la pantalla B"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Esta es la pantalla B"),
      ElevatedButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("Pantalla A"))],),
    );
  }
}
