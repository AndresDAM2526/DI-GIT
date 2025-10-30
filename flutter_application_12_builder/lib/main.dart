import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  List<String> imagenes = [
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x500.png",
    "https://placehold.co/600x600.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x500.png",
    "https://placehold.co/600x600.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x500.png",
    "https://placehold.co/600x600.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 3,
          ),
          itemCount: imagenes.length,
          itemBuilder: (context, indice) {
            String url=imagenes[indice];
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(url),
              ),
            );
          },
        ),
      ),
    );
  }
}
