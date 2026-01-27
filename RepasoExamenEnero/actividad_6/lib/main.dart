import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  List<String> imagenes = [
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
    "https://placehold.co/600x400.png",
  ];
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemCount: imagenes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width > 600 ? 2 : 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(120)),
              ),
              margin: EdgeInsets.all(20),
              child: Card(
                elevation: 12.0,
                child: Image.network(imagenes[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
