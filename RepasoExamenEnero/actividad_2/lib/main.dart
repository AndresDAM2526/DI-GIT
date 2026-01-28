
import 'package:actividad_2/model/usuario.dart';
import 'package:actividad_2/view/card_view.dart';
import 'package:actividad_2/viewmodel/card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CardViewmodel(
        Usuario(nombre: "Pedro", foto: "https://placehold.co/600x400"),
      ),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: CardView()));
  }
}
