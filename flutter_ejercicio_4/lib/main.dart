import 'package:flutter/material.dart';

/*Crea una interfaz que muestre un texto dinámico que cambie al presionar un botón (dentro
de build(), muestra un texto y un botón que actualice el texto cada vez que se pulse).*/
void main() {
  runApp( MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double fontSize = 8;
  double? _aumentarTamanio() {
    setState(() {
      fontSize++;
    });
  }
  double? _reducirTamanio() {
    setState(() {
      fontSize--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Texto dinámico",style: TextStyle(fontSize: fontSize),),
            Row(
              children: [
                ElevatedButton(onPressed: _aumentarTamanio, child: Text("Aumentar tamaño")),
                ElevatedButton(onPressed: _reducirTamanio, child: Text("Reducir tamaño"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
