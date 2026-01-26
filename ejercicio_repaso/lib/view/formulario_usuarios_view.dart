import 'package:ejercicio_repaso/model/usuario_formulario_model.dart';
import 'package:ejercicio_repaso/viewmodel/database_viewmodel.dart';
import 'package:ejercicio_repaso/viewmodel/formulario_usuarios_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioUsuarios extends StatefulWidget {
  const FormularioUsuarios({super.key});

  @override
  State<FormularioUsuarios> createState() => _FormularioUsuariosState();
}

class _FormularioUsuariosState extends State<FormularioUsuarios> {
  DateTime? fechaSeleccionadaFinal;
  final validarFormulario = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final fechaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FormularioUsuariosViewmodel>();
    final viewModelDatabase = context.watch<DatabaseViewmodel>();
    Future<void> seleccionarFecha() async {
      final fechaSeleccionada = await showDatePicker(
        context: context,
        firstDate: DateTime(1950, 12, 31),
        lastDate: DateTime(2030),
        initialDate: DateTime.now(),
      );
      if (fechaSeleccionada != null) {
        setState(() {
          fechaSeleccionadaFinal = fechaSeleccionada;
          viewModel.fechaControlador.text =
              "${fechaSeleccionadaFinal!.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Formulario de usuarios"))),
      body: Form(
        key: validarFormulario,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Card(
                child: TextFormField(
                  validator: (value) => viewModel.validarNombre(value),
                  controller: viewModel.nombreControlador,
                  decoration: InputDecoration(label: Text("Nombre")),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Card(
                child: TextFormField(
                  validator: (value) => viewModel.validarDireccion(value),
                  controller: viewModel.direccionControlador,
                  decoration: InputDecoration(label: Text("Direccion")),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Card(
                child: TextFormField(
                  validator: (value) => viewModel.validarFecha(value),
                  decoration: InputDecoration(
                    label: Text("Fecha de nacimiento"),
                  ),
                  onTap: () => seleccionarFecha(),
                  controller: viewModel.fechaControlador,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (validarFormulario.currentState!.validate()) {
                      UsuarioFormularioModel usuario = UsuarioFormularioModel(
                        nombre: viewModel.nombreControlador.text,
                        direccion: viewModel.direccionControlador.text,
                        fechaNacimiento: viewModel.fechaControlador.text,
                      );
                      viewModelDatabase.anadirUsuario(usuario);
                      viewModel.vaciarCampos();
                    }
                  },
                  child: Text("Enviar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.vaciarCampos();
                  },
                  child: Text("Vaciar campos"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
