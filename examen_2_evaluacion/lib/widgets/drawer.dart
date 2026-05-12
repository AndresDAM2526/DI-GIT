import 'package:examen_2_evaluacion/l10n/app_localizations.dart';
import 'package:examen_2_evaluacion/views/ajustes_view.dart';
import 'package:examen_2_evaluacion/views/gestion_view.dart';
import 'package:examen_2_evaluacion/views/listado_view.dart';
import 'package:flutter/material.dart';

class DrawerPersonalizado extends StatelessWidget {
  DrawerPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Icon(Icons.person),
            accountEmail: Text(l10n!.drawerTitulo),
          ),
          ListTile(
            leading: Icon(Icons.library_add),
            title: Text(l10n!.drawerGestion),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GestionView()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text(l10n!.drawerListado),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListadoView()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(l10n!.drawerAjustes),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjustesView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
