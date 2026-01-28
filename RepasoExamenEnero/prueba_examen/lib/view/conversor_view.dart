import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_examen/model/transaccion_model.dart';
import 'package:prueba_examen/viewmodel/conversor_viewmodel.dart';
import 'package:prueba_examen/viewmodel/database_viewmodel.dart';

class ConversorView extends StatefulWidget {
  const ConversorView({super.key});

  @override
  State<ConversorView> createState() => _ConversorViewState();
}

class _ConversorViewState extends State<ConversorView> {
  final validarFormulario = GlobalKey<FormState>();
  String unidadInicialSeleccionada = "";
  String unidadFinalSeleccionada = "";
  double? valorFinal;
  @override
  Widget build(BuildContext context) {
    final viewModelConversion = context.watch<ConversorViewmodel>();
    final viewModelDatos = context.watch<DatabaseViewmodel>();
    List<String> unidadesP = viewModelConversion.conversionRates.keys.toList();
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Conversor"))),
      body: Form(
        key: validarFormulario,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: viewModelConversion.valor,
                validator: (value) => viewModelConversion.validarValor(value),
                decoration: InputDecoration(
                  label: Text("Introduzca el valor"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButton(
                hint: Text(unidadInicialSeleccionada),
                items: unidadesP
                    .map(
                      (unidad) =>
                          DropdownMenuItem(value: unidad, child: Text(unidad)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    unidadInicialSeleccionada = value!;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButton(
                hint: Text(unidadFinalSeleccionada),
                items: unidadesP
                    .map(
                      (unidad) =>
                          DropdownMenuItem(value: unidad, child: Text(unidad)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    unidadFinalSeleccionada = value!;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (validarFormulario.currentState!.validate()) {
                  setState(() {
                    valorFinal = viewModelConversion.realizarConversion(
                      unidadInicialSeleccionada!,
                      unidadFinalSeleccionada!,
                      double.parse(viewModelConversion.valor.text),
                    );
                    viewModelDatos.guardarTransaccion(
                      TransaccionModel(
                        valorInicial: double.parse(
                          viewModelConversion.valor.text,
                        ),
                        unidadInicial: unidadInicialSeleccionada,
                        unidadFinal: unidadFinalSeleccionada,
                        valorFinal: valorFinal!,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Transacción guardada correctamente"),
                      ),
                    );
                  });
                }
              },
              child: Text("Convertir y guardar"),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: valorFinal == null
                  ? Text("")
                  : valorFinal! < 1
                  ? Text("Resultado: $valorFinal $unidadFinalSeleccionada")
                  : Text(
                      "Resultado: ${valorFinal!.toStringAsFixed(2)} $unidadFinalSeleccionada",
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
