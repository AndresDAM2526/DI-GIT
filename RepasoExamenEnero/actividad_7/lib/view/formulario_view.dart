import 'package:actividad_7/l10n/app_localizations.dart';
import 'package:actividad_7/viewmodel/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioView extends StatelessWidget {
  const FormularioView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormularioViewmodel>();
    final validadorFormulario = GlobalKey<FormState>();
    final l10n=AppLocalizations.of(context);
    return Form(
      key: validadorFormulario,
      child: Column(
        children: [
          Semantics(
            label: "Campo del nombre",
            hint: "Campo donde se escribe el nombre",
            child: Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: TextFormField(
                  controller: viewModel.nombreControlador,
                  validator: (value) => viewModel.validarNombre(value),
                  decoration: InputDecoration(label: Text(l10n!.name)),
                ),
              ),
            ),
          ),
          Semantics(
            label: "Campo del teléfono",
            hint: "Campo donde se escribe el nombre",
            child: Container(
              margin: EdgeInsets.all(10),
              child: Card(
                child: TextFormField(
                  validator: (value) => viewModel.validarTelefono(value),
                  controller: viewModel.telefonoControlador,
                  decoration: InputDecoration(label: Text(l10n!.telephone)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Semantics(
                label: "Botón de enviar",
                hint: "Botón para enviar los datos del formulario",
                child: ElevatedButton(
                  onPressed: () {
                    if (validadorFormulario.currentState!.validate()) {
                      viewModel.enviarFormulario();
                      final snackBar = SnackBar(
                        content: Text("Enviado"),
                        duration: Duration(microseconds: 1000),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(l10n.submit),
                ),
              ),
              Semantics(
                label: "Botón de enviar",
                hint: "Botón para enviar los datos del formulario",
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.vaciarCampos();
                  },
                  child: Text(l10n.clear),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
