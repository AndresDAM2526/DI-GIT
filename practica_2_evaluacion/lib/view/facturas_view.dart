import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';

import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';

class Facturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Facturas"))),
      body: FutureBuilder(
        future: context.read<DatabaseProvider>().obtenerFacturas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final facturas = snapshot.data!;
          return Semantics(
            label: "Lista de las facturas",
            hint:
                "Se visualiza la lista de facturas. En cada registro de se el identificador de la factura, la fecha y el importe total de la factura",
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final factura = facturas[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      leading: Text(factura['idFactura'].toString()),
                      title: Text(factura['fecha']),
                      subtitle: Text(factura['total'].toString()),
                      trailing: Semantics(
                        label:
                            "Botón para generar un PDF con los datos de esa factura",
                        hint: "Se genera un PDF con los datos de la factura",
                        child: ElevatedButton(
                          onPressed: () async {
                            final productos = context
                                .read<DatabaseProvider>()
                                .productosFactura(factura['idFactura']);
                            context.read<DatabaseProvider>().generarPDF(
                              productos,
                              factura['idFactura'],
                              factura['fecha'],
                              factura['total'],
                            );
                          },
                          child: Text(l10n!.generatePDF),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
