import 'package:flutter/material.dart';

class ParseView extends StatefulWidget {
  const ParseView({super.key});

  @override
  State<ParseView> createState() => _ParseViewState();
}

class _ParseViewState extends State<ParseView> {
  String? error;
  String valor = "";
  void convertStringToInt(String value) {
    try {
      int numero = int.parse(value);
      setState(() {
        error = "El número es : $numero";
      });
      
    } catch (e) {
      setState(() {
        error = "Error: $valor no es un numero válido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(label: Text("Introduzca un numero")),
            onChanged: (value) => valor = value,
          ),
          ElevatedButton(
            onPressed: () {
              convertStringToInt(valor);
            },
            child: Text(error ?? ""),
          ),
          Text(error!),
        ],
      ),
    );
  }
}
