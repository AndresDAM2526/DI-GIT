import 'package:examen_2_evaluacion/l10n/app_localizations.dart';
import 'package:examen_2_evaluacion/services/database_service.dart';
import 'package:examen_2_evaluacion/viewmodels/formulario_viewmodel.dart';
import 'package:examen_2_evaluacion/viewmodels/tema_viewmodel.dart';
import 'package:examen_2_evaluacion/views/ajustes_view.dart';
import 'package:examen_2_evaluacion/views/gestion_view.dart';
import 'package:examen_2_evaluacion/views/listado_view.dart';
import 'package:examen_2_evaluacion/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TemaViewmodel()),
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => FormularioViewmodel()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final viewModelTema = context.watch<TemaViewmodel>();

    return Consumer<DatabaseService>(
      builder: (context, value, child) {
        final idioma = viewModelTema.idioma;
        return MaterialApp(
          theme: ThemeData(
            textTheme: TextTheme(
              titleLarge: TextStyle(fontSize: viewModelTema.tamano * 20),
              bodyLarge: TextStyle(fontSize: viewModelTema.tamano * 20),
              bodyMedium: TextStyle(fontSize: viewModelTema.tamano * 20),
              bodySmall: TextStyle(fontSize: viewModelTema.tamano * 20),
              labelLarge: TextStyle(fontSize: viewModelTema.tamano * 20),
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: viewModelTema.tema,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('es'), Locale('en')],
          locale: Locale(idioma == "Español" ? 'es' : 'en'),
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context);
              return Scaffold(
                appBar: AppBar(),
                drawer: DrawerPersonalizado(),
                body: Center(child: Text("Pagina principal")),
              );
            },
          ),
        );
      },
    );
  }
}
