import 'package:actividad_7/l10n/app_localizations.dart';
import 'package:actividad_7/view/formulario_view.dart';
import 'package:actividad_7/viewmodel/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FormularioViewmodel(),
      child: MainApp(),
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
      locale: Locale('en'),
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text("Formulario de registro"))),
        body: FormularioView(),
      ),
    );
  }
}
