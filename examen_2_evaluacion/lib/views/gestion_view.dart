import 'package:examen_2_evaluacion/l10n/app_localizations.dart';
import 'package:examen_2_evaluacion/model/libro_formulario_model.dart';
import 'package:examen_2_evaluacion/services/database_service.dart';
import 'package:examen_2_evaluacion/viewmodels/formulario_viewmodel.dart';
import 'package:examen_2_evaluacion/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionView extends StatefulWidget {
  const GestionView({super.key});

  @override
  State<GestionView> createState() => _GestionViewState();
}

class _GestionViewState extends State<GestionView> {
  String generoSeleecionado = "";
  List<String> generos = ["Novela", "Ensayo", "Ciencia", "Fantasia"];
  List<Widget> elementosToggle = [Text("DISPONIBLE"), Text("PRESTADO")];
  List<bool> tipoSeleccionado = [false, false];
  TextEditingController controladorTitulo = TextEditingController();
  TextEditingController controladorAutor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewModel = context.watch<DatabaseService>();
    final viewModelFormulario = context.watch<FormularioViewmodel>();
    final validarFormulario = GlobalKey<FormState>();
    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(title: Center(child: Text(l10n!.vistaGestion))),
      body: Container(
        margin:EdgeInsets.all(100) ,
        child: Card(
          elevation: 12,
          child: Form(
            key: validarFormulario,
            child: Column(
              children: [
                Text(l10n!.nuevoLibro),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controladorTitulo,
                    validator: (value) =>
                        viewModelFormulario.validarTitulo(value),
                    decoration: InputDecoration(
                      label: Text(l10n!.titulo),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controladorAutor,
                    validator: (value) =>
                        viewModelFormulario.validarAutor(value),
                    decoration: InputDecoration(
                      label: Text(l10n.autor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    //validator: (value) => viewModelFormulario.validarGenero(value),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: generoSeleecionado == ""
                        ? Text(l10n.genero)
                        : Text(generoSeleecionado),
                    items: generos
                        .map(
                          (genero) => DropdownMenuItem(
                            value: genero,
                            child: Text(genero),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        generoSeleecionado = value!;
                      });
                    },
                  ),
                ),
                /*
                FutureBuilder(
                  future: viewModel.cargarGeneros(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    final generosFuture = snapshot.data ?? [];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        hint: generoSeleecionado == ""
                            ? Text("Género")
                            : Text(generoSeleecionado!),
                        items: generosFuture
                            .map(
                              (genero) => DropdownMenuItem(
                                value: genero,
                                child: Text(genero),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          generoSeleecionado = value;
                        },
                      ),
                    );
                  },
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Estado",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                ToggleButtons(
                  fillColor: tipoSeleccionado[0] ? Colors.green : Colors.red,
                  isSelected: tipoSeleccionado,
                  children: elementosToggle,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < tipoSeleccionado.length; i++) {
                        tipoSeleccionado[i] = (i == index);
                      }
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (validarFormulario.currentState!.validate()) {
                        final nuevoLibro = LibroFormularioModel(
                          titulo: controladorTitulo.text,
                          autor: controladorAutor.text,
                          genero: generoSeleecionado!,
                          estado: tipoSeleccionado[0]
                              ? l10n.disponible
                              : l10n!.prestado,
                          fecha: DateTime.now(),
                        );
                        viewModel.insertarLibro(nuevoLibro);
                      }
                    },
                    child: Text(l10n!.guardar),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
