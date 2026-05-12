import 'package:examen_2_evaluacion/l10n/app_localizations.dart';
import 'package:examen_2_evaluacion/viewmodels/tema_viewmodel.dart';
import 'package:examen_2_evaluacion/widgets/card_ajustes_widget.dart';
import 'package:examen_2_evaluacion/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AjustesView extends StatefulWidget {
  const AjustesView({super.key});

  @override
  State<AjustesView> createState() => _AjustesViewState();
}

class _AjustesViewState extends State<AjustesView> {
  List<String> idiomas = ["Español", "Ingles"];
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TemaViewmodel>();
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(title: Center(child: Text(l10n!.ajustes))),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          CardAjustesWidget(
            titulo: l10n!.modoOscuro,
            elemento: Switch(
              value: viewModel.modoOscuro,
              onChanged: (value) {
                setState(() {
                  viewModel.cambiarTema();
                });
              },
            ),
          ),
          CardAjustesWidget(
            titulo: l10n!.idioma,
            elemento: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              hint: Text(viewModel.idioma),
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
          CardAjustesWidget(
            titulo: l10n!.tamanoTexto,
            elemento: Slider(
              min: 0.8,
              max: 2.0,
              divisions: 6,
              value: viewModel.tamano,
              onChanged: (value) {
                setState(() {
                  viewModel.cambiarTamanio(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
