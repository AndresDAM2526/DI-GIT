import 'package:flutter/material.dart';

class FormularioGastos extends StatelessWidget {
  FormularioGastos({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tiposIngresos = ['Nómina', 'Donación'];
    List<String> tiposGastos = ['Alquiler', 'Internet', 'Comida', 'Cine'];
    List<Widget> elementosToggle = [Text("Gasto"), Text("Ingreso")];
    List<bool> tipoSeleccionado = [false, false];
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Formulario usuarios"))),
      body: Container(
        margin: EdgeInsets.all(4),
        child: Form(
          child: Column(
            children: [
              ToggleButtons(
                isSelected: tipoSeleccionado,
                children: elementosToggle,
              ),
              TextFormField(),
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
