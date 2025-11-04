import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool primerElemento = false;
  bool segundoElemento = false;
  bool tercerElemento = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(
              title: Text(
                "Tarea 1",
                style: TextStyle(
                  color: primerElemento ? Colors.grey : Colors.black,
                  decoration: primerElemento
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                "Terminar ejercicios",
                style: TextStyle(
                  color: primerElemento ? Colors.grey : Colors.black,
                  decoration: primerElemento
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                checkColor: Colors.black,
                value: primerElemento,
                onChanged: (bool? value) {
                  setState(() {
                    primerElemento = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                "Tarea 2",
                style: TextStyle(
                  color: segundoElemento ? Colors.grey : Colors.black,
                  decoration: segundoElemento
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                "Gym",
                style: TextStyle(
                  color: segundoElemento ? Colors.grey : Colors.black,
                  decoration: segundoElemento
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                checkColor: Colors.black,
                value: segundoElemento,
                onChanged: (bool? value) {
                  setState(() {
                    segundoElemento = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                "Tarea 3",
                style: TextStyle(
                  color: tercerElemento ? Colors.grey : Colors.black,
                  decoration: tercerElemento
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                "Comprar",
                style: TextStyle(
                  color: tercerElemento ? Colors.grey : Colors.black,
                  decoration: tercerElemento
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                checkColor: Colors.black,
                value: tercerElemento,
                onChanged: (bool? value) {
                  setState(() {
                    tercerElemento = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
