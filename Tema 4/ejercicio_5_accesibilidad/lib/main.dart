import 'package:ejercicio_5_accesibilidad/l10n/app_localizations.dart';
import 'package:ejercicio_5_accesibilidad/viewmodels/formulario_viewmodel.dart';
import 'package:ejercicio_5_accesibilidad/views/homepage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FormularioViewmodel(),
      child:  MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('es'),
      ], //Si se quisiera cambiar se puede probar la variable dentro del locale
      home: Homepage(),
    );
  }
}
