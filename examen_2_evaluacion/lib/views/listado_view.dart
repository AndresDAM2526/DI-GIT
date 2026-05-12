import 'package:examen_2_evaluacion/l10n/app_localizations.dart';
import 'package:examen_2_evaluacion/l10n/app_localizations_en.dart';
import 'package:examen_2_evaluacion/services/database_service.dart';
import 'package:examen_2_evaluacion/widgets/card_libro.dart';
import 'package:examen_2_evaluacion/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListadoView extends StatefulWidget {
  const ListadoView({super.key});

  @override
  State<ListadoView> createState() => _ListadoViewState();
}

class _ListadoViewState extends State<ListadoView> {
  
  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context);
    final viewModel = context.watch<DatabaseService>();
    final libros = viewModel.libros;
    
    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(title: Center(child: Text(l10n!.listado))),
      body: ListView.builder(
        itemCount: libros.length,
        itemBuilder: (context, index) {
          return CardLibro(
            icon: libros[index]['state'] == "Disponible"
                ? Icon(Icons.check_circle)
                : Icon(Icons.cancel),
            libro: libros[index]['title'],
            subtitulo:
                "${libros[index]['title']} · ${libros[index]['id_genre']} · ${libros[index]['date']}",
            idLibro: libros[index]['id'],
          
          );
        },
      ),
    );
  }
}
