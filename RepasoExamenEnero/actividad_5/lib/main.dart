import 'package:actividad_5/view/ajustes_view.dart';
import 'package:actividad_5/viewmodel/ajustes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AjustesViewmodel(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<AjustesViewmodel>().tema,
      home: Scaffold(body: AjustesView()),
    );
  }
}
