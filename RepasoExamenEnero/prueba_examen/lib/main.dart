import 'package:flutter/material.dart';
import 'package:prueba_examen/view/ajustes_view.dart';
import 'package:prueba_examen/view/conversor_view.dart';
import 'package:prueba_examen/viewmodel/conversor_viewmodel.dart';
import 'package:prueba_examen/viewmodel/database_viewmodel.dart';
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
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseViewmodel>(
      builder: (_, value, __) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text("Menu")),
                ListTile(leading: Icon(Icons.compare_arrows_rounded)),
                ListTile(leading: Icon(Icons.format_line_spacing_sharp)),
                ListTile(leading: Icon(Icons.settings)),
              ],
            ),
          ),
          body: ConversorView(),
        ),
      ),
    );
  }
}
