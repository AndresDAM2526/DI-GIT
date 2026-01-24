import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/view/ajustes_view.dart';
import 'package:practica_2_evaluacion/view/facturas_view.dart';
import 'package:practica_2_evaluacion/view/productos_view.dart';
import 'package:practica_2_evaluacion/viewmodel/csv_viewmodel.dart';
import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:practica_2_evaluacion/viewmodel/formulario_viewmodel.dart';
import 'package:practica_2_evaluacion/viewmodel/tema_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
        ChangeNotifierProvider(create: (context) => FormularioViewmodel()),
        ChangeNotifierProvider(create: (context) => TemaViewmodel()),
        ChangeNotifierProvider(create: (context) => CsvViewmodel(),)
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
  int indicePagina = 0;
  List<Widget> paginas = [Productos(), Facturas(), Ajustes()];
  @override
  Widget build(BuildContext context) {
    return Consumer<TemaViewmodel>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(context.watch<TemaViewmodel>().idioma),
          supportedLocales: [Locale('es'), Locale('en')],
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value.tema,
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context);
              return Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: indicePagina,
                  onTap: (value) {
                    setState(() {
                      indicePagina = value;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.inventory),
                      label: l10n!.bottomNavigationLabelStock,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.blinds_closed_sharp),
                      label: l10n.bottomNavigationLabelInvoices,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: l10n.bottomNavigationLabelSettings,
                    ),
                  ],
                ),
                body: paginas[indicePagina],
              );
            },
          ),
        );
      },
    );
  }
}
