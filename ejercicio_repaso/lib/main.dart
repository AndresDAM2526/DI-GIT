import 'package:ejercicio_repaso/view/pantalla_principal_view.dart';
import 'package:ejercicio_repaso/viewmodel/database_viewmodel.dart';
import 'package:ejercicio_repaso/viewmodel/formulario_usuarios_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FormularioUsuariosViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => DatabaseViewmodel()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PantallaPrincipalView());
  }
}
