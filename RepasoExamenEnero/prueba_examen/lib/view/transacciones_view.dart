import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_examen/l10n/app_localizations.dart';
import 'package:prueba_examen/viewmodel/database_viewmodel.dart';

class TransaccionesView extends StatefulWidget {
  const TransaccionesView({super.key});

  @override
  State<TransaccionesView> createState() => _TransaccionesViewState();
}

class _TransaccionesViewState extends State<TransaccionesView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DatabaseViewmodel>();
    final l10n = AppLocalizations.of(context);
    List<Map<String, dynamic>> datos = viewModel.transacciones;
    return Scaffold(
      appBar: AppBar(title: Text(l10n!.transacciones)),
      body: datos.isEmpty
          ? Center(child: Text("No hay datos aún"))
          : ListView.builder(
              itemCount: datos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      "${datos[index]['valor_inicial']} ${datos[index]['unidad_inicial']} -> ${datos[index]['unidad_final']}",
                    ),
                    subtitle: Text("Result: ${datos[index]['valor_final']}"),
                    trailing: FloatingActionButton(
                      heroTag: "${datos[index]['id_conversion']}-borrar",
                      onPressed: () {
                        setState(() {
                          viewModel.borrarTransaccion(
                            datos[index]['id_conversion'],
                          );
                        });
                      },
                      child: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
