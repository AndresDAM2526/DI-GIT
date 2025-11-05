import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  Perfil({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/perfil');
            },
            child: Text("Perfil"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/ajustes');
            },
            child: Text("Ajustes"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Text("Página principal"),
          ),
        ],
      ),
    );
  }
}
