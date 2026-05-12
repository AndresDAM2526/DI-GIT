import 'package:examen_2_evaluacion/l10n/app_localizations.dart';
import 'package:examen_2_evaluacion/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardLibro extends StatefulWidget {
  String libro;
  String subtitulo;
  Icon icon;
  int idLibro;
  CardLibro({
    super.key,
    required this.icon,
    required this.libro,
    required this.subtitulo,
    required this.idLibro,
  });

  @override
  State<CardLibro> createState() => _CardLibroState();
}

class _CardLibroState extends State<CardLibro> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewModel = context.watch<DatabaseService>();
    return Card(
      child: ListTile(
        leading: widget.icon,
        title: Text(
          widget.libro,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.subtitulo,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              viewModel.borrarLibro(widget.idLibro);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10n!.libroEliminado)));
            });
          },
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}
