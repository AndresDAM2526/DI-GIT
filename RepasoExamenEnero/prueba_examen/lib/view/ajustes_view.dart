import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Ajustes"))),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text("Modo oscuro"),
              trailing: Switch(value: false, onChanged: (value) => false),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Idioma"),
              trailing: DropdownButton(
                hint: Text("Idioma"),
                value: idiomaSeleccionado,
                items: idiomas
                    .map(
                      (idioma) =>
                          DropdownMenuItem(value: idioma, child: Text(idioma)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    idiomaSeleccionado = value!;
                  });
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Modo oscuro"),
              subtitle: Slider(
                divisions: 4,
                value: valorSlider,
                onChanged: (value) {
                  setState(() {
                    valorSlider = value;
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
