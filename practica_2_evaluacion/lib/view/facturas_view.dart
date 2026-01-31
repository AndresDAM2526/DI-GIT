import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';

import 'package:practica_2_evaluacion/viewmodel/database_viewmodel.dart';
import 'package:provider/provider.dart';

///Vista que muestra en un ListView el identificador de la factura, la fecha, el total y un botón para generar el pdf con esa información
class Facturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Facturas"))),
      body: FutureBuilder(
        future: context.read<DatabaseProvider>().obtenerFacturas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return Center(child: Text(l10n!.emptyInvoice));
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
                      title: Text(
                        "${l10n!.orderDate}: ${factura['fecha']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        " ${l10n.total}: ${NumberFormat.currency(locale: locale.toString()).format(double.parse(factura['total'].toString()))}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
