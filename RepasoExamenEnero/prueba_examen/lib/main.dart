import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prueba_examen/l10n/app_localizations.dart';
import 'package:prueba_examen/view/ajustes_view.dart';
import 'package:prueba_examen/view/conversor_view.dart';
import 'package:prueba_examen/view/transacciones_view.dart';
import 'package:prueba_examen/viewmodel/conversor_viewmodel.dart';
import 'package:prueba_examen/viewmodel/database_viewmodel.dart';
import 'package:prueba_examen/viewmodel/tema_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseViewmodel()),
        ChangeNotifierProvider(create: (context) => ConversorViewmodel()),
        ChangeNotifierProvider(create: (context) => TemaViewmodel()),
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
    final viewModel = context.watch<TemaViewmodel>();
    final idioma = viewModel.idioma == "Español" ? 'es' : 'en';
    return Consumer<DatabaseViewmodel>(
      builder: (_, value, __) => MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('es'), Locale('en')],
        locale: Locale(idioma),
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: viewModel.tamanio),
            bodyLarge: TextStyle(fontSize: viewModel.tamanio),
            labelLarge: TextStyle(fontSize: viewModel.tamanio),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: viewModel.tema,
        home: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context);
            return Scaffold(
              appBar: AppBar(),
              drawer: Drawer(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(l10n!.menu),
                    ),
                    ListTile(
                      leading: Icon(Icons.compare_arrows_rounded),
                      title: Text(l10n.conversor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConversorView(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.format_line_spacing_sharp),
                      title: Text(l10n.transacciones),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransaccionesView(),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(l10n.ajustes),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AjustesView()),
                      ),
                    ),
                  ],
                ),
              ),
              body: ConversorView(),
            );
          },
        ),
      ),
    );
  }
}
