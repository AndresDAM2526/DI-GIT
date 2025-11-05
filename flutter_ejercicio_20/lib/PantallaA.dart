import 'package:flutter/material.dart';
import 'package:flutter_ejercicio_20/PantallaB.dart';

class PantallaA extends StatelessWidget{
  const PantallaA({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla A"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Esta es la pantalla A"),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaB()));
          }, child: Text("Pantalla B"))
        ],
      ),
    );
  }
}