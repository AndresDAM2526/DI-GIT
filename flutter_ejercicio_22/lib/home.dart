import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina principal"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
        ],
      ),
    );
  }
}
