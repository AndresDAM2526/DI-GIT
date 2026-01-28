import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_examen/l10n/app_localizations.dart';
import 'package:prueba_examen/viewmodel/tema_viewmodel.dart';

class AjustesView extends StatefulWidget {
  const AjustesView({super.key});

  @override
  State<AjustesView> createState() => _AjustesViewState();
}

class _AjustesViewState extends State<AjustesView> {
  List<String> idiomas = ["Español", "English"];
  String? idiomaSeleccionado;
  double valorSlider = 0;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewModel = context.watch<TemaViewmodel>();
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.ajustes))),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(l10n.modoOscuro),
              trailing: Switch(
                value: viewModel.modoOscuro,
                onChanged: (value) {
                  setState(() {
                    viewModel.cambiarTema();
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(l10n.idioma),
              trailing: DropdownButton(
                hint: Text(viewModel.idioma),
                value: idiomaSeleccionado,
                items: idiomas
                    .map(
                      (idioma) =>
                          DropdownMenuItem(value: idioma, child: Text(idioma)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    viewModel.cambiarIdioma(value!);
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(l10n.tamanoTexto),
              subtitle: Slider(
                min: 10.0,
                max: 50.0,
                divisions: 4,
                value: viewModel.tamanio,
                onChanged: (value) {
                  setState(() {
                    viewModel.cambiarTamanio(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
