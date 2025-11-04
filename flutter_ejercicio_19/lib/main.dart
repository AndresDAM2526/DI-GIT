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
  double valor = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: valor),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (valor == 1.0) {
                    valor = 1.0;
                  } else {
                    valor += 0.1;
                  }
                });
              },
              child: Text("Aumentar"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (valor == 0.0) {
                    valor = 1.0;
                  } else {
                    valor -= 0.1;
                  }
                });
              },
              child: Text("Reducir"),
            ),
          ],
        ),
      ),
    );
  }
}
