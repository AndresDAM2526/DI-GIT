import 'package:flutter/material.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/viewmodel/tema_viewmodel.dart';
import 'package:provider/provider.dart';

///Vista que permite cambiar la apariencia de la aplicacion
class Ajustes extends StatefulWidget {
  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  double tamanio = 0.0;
  List<String> idiomas = ["Español", "English"];

  GlobalKey<FormState> keyDropDown = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.setingsTitle))),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.darkMode,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Semantics(
                        label:
                            "Switch que permite cambiar el tema al modo oscuro",
                        hint:
                            "Al activar el switch, todo el tema de la aplicación se cambia a modo oscuro",
                        child: Switch(
                          value: context.read<TemaViewmodel>().modoOscuro,
                          onChanged: (value) {
                            setState(() {
                              context.read<TemaViewmodel>().cambiarTema();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      l10n.fontSize,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Semantics(
                      label: "Permite cambiar el tamaño de la fuente",
                      hint:
                          "Al deslizar nos permite aumentar o disminuir el tamaño de la fuente",
                      child: Slider(
                        min: 0.8,
                        max: 2.0,
                        divisions: 6,
                        value: context.read<TemaViewmodel>().tamano,
                        onChanged: (value) {
                          setState(() {
                            context.read<TemaViewmodel>().cambiarTamanio(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        l10n.language,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Semantics(
                      label:
                          "Menú desplegable que permite cambiar el idioma de la aplicación",
                      hint:
                          "Menú que permite al usuario cambiar el idioma de la aplicación",
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          key: keyDropDown,
                          hint: Text(context.read<TemaViewmodel>().idioma),
                          items: idiomas.map((idioma) {
                            return DropdownMenuItem<String>(
                              value: idioma,
                              child: Text(idioma),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              context.read<TemaViewmodel>().cambiarIdioma(
                                value!,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
