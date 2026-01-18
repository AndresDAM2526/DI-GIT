import 'package:flutter/material.dart';
import 'package:pratica_2_evaluacion/l10n/app_localizations.dart';
import 'package:pratica_2_evaluacion/viewmodel/tema_viewmodel.dart';
import 'package:provider/provider.dart';

class Ajustes extends StatefulWidget {
  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  double tamanio = 0.0;
  List<String> idiomas = ["es", "en"];

  String idiomaLocale = "es";
  GlobalKey<FormState> keyDropDown = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String idiomaSeleccionado = context.read<TemaViewmodel>().idioma;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n!.setingsTitle))),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n!.darkMode),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Switch(
                        value: context.read<TemaViewmodel>().modoOscuro,
                        onChanged: (value) {
                          setState(() {
                            context.read<TemaViewmodel>().cambiarTema();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(l10n!.fontSize),
                    Slider(
                      value: tamanio,
                      onChanged: (value) {
                        setState(() {
                          tamanio = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(l10n!.language),
                    ),
                    DropdownButton(
                      key: keyDropDown,
                      value: idiomaSeleccionado,
                      items: idiomas.map((idioma) {
                        return DropdownMenuItem<String>(
                          value: idioma,
                          child: Text(idioma),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          idiomaSeleccionado = value!;
                          idiomaLocale = (idiomaSeleccionado == "es")
                              ? "es"
                              : "en";
                          context.read<TemaViewmodel>().cambiarIdioma(
                            idiomaLocale,
                          );
                        });
                      },
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
