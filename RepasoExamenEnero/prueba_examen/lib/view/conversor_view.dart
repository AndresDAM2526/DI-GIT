import 'package:flutter/material.dart';

class ConversorView extends StatefulWidget {
  const ConversorView({super.key});

  @override
  State<ConversorView> createState() => _ConversorViewState();
}

class _ConversorViewState extends State<ConversorView> {
  List<String> unidades = ["Kilómetros", "Metros", "Millas"];
  String? unidadInicialSeleccionada;
  String? unidadFinalSeleccionada;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Conversor"))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                label: Text("Introduzca el valor"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton(
              items: unidades
                  .map(
                    (unidad) =>
                        DropdownMenuItem(value: unidad, child: Text(unidad)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  unidadInicialSeleccionada = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: DropdownButton(
              items: unidades
                  .map(
                    (unidad) =>
                        DropdownMenuItem(value: unidad, child: Text(unidad)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  unidadFinalSeleccionada = value;
                });
              },
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text("Convertir y guardar")),
          Container(margin: EdgeInsets.all(10),child: Text("Resultado"))
        ],
      ),
    );
  }
}
