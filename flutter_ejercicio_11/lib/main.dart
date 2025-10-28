import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Form(child: Column(children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Nombre"),validator: (value) {
              
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Correo electrónico"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Contraseña"),onChanged: (text) {
              
            },
            obscureText: true,
          ),
          ElevatedButton(onPressed: (){}, child:Text("Enviar"))
        ],)),
      ),
    );
  }
}
