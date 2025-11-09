import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PaginaPrincipal());
  }
}

class PaginaPrincipal extends StatefulWidget {
  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  Color colorElegido = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(color: colorElegido, child: Text("color")),
            ElevatedButton(
              onPressed: () async {
                final colorSeleccionado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeleccionColor()),
                );
                setState(() {
                  if (colorSeleccionado == null) {
                    colorElegido = Colors.black;
                  } else {
                    colorElegido = colorSeleccionado;
                  }
                });
              },
              child: Text("Selector de color"),
            ),
          ],
        ),
      ),
    );
  }
}

class SeleccionColor extends StatelessWidget {
  SeleccionColor({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Colors.red);
            },
            child: Text("Rojo"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Colors.green);
            },
            child: Text("Verde"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Colors.blue);
            },
            child: Text("Azul"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Colors.black);
            },
            child: Text("Negro"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Colors.yellow);
            },
            child: Text("Amarillo"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Colors.orange);
            },
            child: Text("Naranja"),
          ),
        ],
      ),
    );
  }
}
