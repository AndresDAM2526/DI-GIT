import 'package:ejercicio_5_accesibilidad/l10n/app_localizations.dart';
import 'package:ejercicio_5_accesibilidad/viewmodels/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  final formularioKey = GlobalKey<FormState>();
  final controladorNombre = TextEditingController();
  final controladorCorreo = TextEditingController();
  final controladorTelefono = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewModel = context.watch<FormularioViewmodel>();
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.name))),
      body: Form(
        key: formularioKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: TextFormField(
                    validator: (value) => viewModel.validarNombre(value),
                    controller: viewModel.controladorNombre,
                    decoration: InputDecoration(
                      label: Text(l10n.name),
                      //labelText: l10n.labelName,
                      hintText: l10n.hintName,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: TextFormField(
                    validator: (value) => viewModel.validarCorreo(value),
                    controller: viewModel.controladorCorreo,
                    decoration: InputDecoration(
                      label: Text(l10n.email),
                      //labelText: l10n.labelEmail,
                      hintText: l10n.hintEmail,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: TextFormField(
                    validator: (value) => viewModel.validarTelefono(value),
                    controller: viewModel.controladorTelefono,
                    decoration: InputDecoration(
                      label: Text(l10n.tf),
                      //labelText: l10n.labelTf,
                      hintText: l10n.hintTf,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () {
                      if (formularioKey.currentState!.validate()) {
                        viewModel.enviarFormulario(
                          viewModel.controladorNombre.text,
                          viewModel.controladorCorreo.text,
                          viewModel.controladorTelefono.text,
                        );
                        viewModel.limpiarFormulario();
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.submit),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () {
                      viewModel.limpiarFormulario();
                    },
                    child: Text(AppLocalizations.of(context)!.clear),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
