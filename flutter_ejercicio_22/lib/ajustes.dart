import 'package:flutter/material.dart';

class Ajustes extends StatelessWidget {
  Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajustes")),
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
              Navigator.pushNamed(context, '/home');
            },
            child: Text("Página principal"),
          ),
        ],
      ),
    );
  }
}
