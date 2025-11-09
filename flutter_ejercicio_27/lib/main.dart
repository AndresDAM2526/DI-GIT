import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool oscuro = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: oscuro ? ThemeData.dark() : ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: oscuro ? ThemeMode.dark : ThemeMode.light,
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                final modoOscuro = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaModoOscuro()),
                );
                setState(() {
                  oscuro = modoOscuro;
                });
              },
              child: Text("Página modo oscuro"),
            ),
          ),
        ),
      ),
    );
  }
}

class PaginaModoOscuro extends StatefulWidget {
  @override
  State<PaginaModoOscuro> createState() => _PaginaModoOscuroState();
}

class _PaginaModoOscuroState extends State<PaginaModoOscuro> {
  bool estadoSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Switch(
              value: estadoSwitch,
              onChanged: (value) => setState(() {
                estadoSwitch = value;
              }),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, estadoSwitch);
              },
              child: Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
