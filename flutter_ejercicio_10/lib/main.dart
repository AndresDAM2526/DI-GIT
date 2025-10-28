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
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 10,color: Colors.red,blurStyle: BlurStyle.outer)
                ],
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.network("https://placehold.co/600x400/png"),
                title: Text("Nombre:"),
                subtitle: Text("Precio:"),
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 10,color: Colors.red,blurStyle: BlurStyle.outer)
                ],
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.network("https://placehold.co/600x400/png"),
                title: Text("Nombre:"),
                subtitle: Text("Precio:"),
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 10,color: Colors.red,blurStyle: BlurStyle.outer)
                ],
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.all(20),
              child: ListTile(
                leading: Image.network("https://placehold.co/600x400/png"),
                title: Text("Nombre:"),
                subtitle: Text("Precio:"),
                contentPadding: EdgeInsets.all(20),
              ),
            ),
          ],
        )
      ),
    );
  }
}
