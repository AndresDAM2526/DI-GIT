import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.sizeOf(context).width < 600
                ? 1
                : MediaQuery.sizeOf(context).width < 840
                ? 2
                : 4,
          ),
          itemBuilder: (context, index) {
            return Card(
              color: index % 2 == 0 ? Colors.red : Colors.blue,
              child: Text("hola + $index"),
            );
          },
        ),
      ),
    );
  }
}
