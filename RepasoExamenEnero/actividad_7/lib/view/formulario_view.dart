import 'package:actividad_7/viewmodel/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioView extends StatelessWidget {
  const FormularioView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormularioViewmodel>();
    final validadorFormulario = GlobalKey<FormState>();
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
                  decoration: InputDecoration(label: Text("Nombre")),
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
                  decoration: InputDecoration(label: Text("Teléfono")),
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
                      SnackBar(
                        content: Text("Formulario enviado correctamente"),
                      );
                    }
                  },
                  child: Text("Enviar"),
                ),
              ),
              Semantics(
                label: "Botón de enviar",
                hint: "Botón para enviar los datos del formulario",
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.vaciarCampos();
                  },
                  child: Text("Vaciar campos"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
