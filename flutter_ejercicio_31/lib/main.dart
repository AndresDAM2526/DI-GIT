import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final _validarFormulario=GlobalKey<FormState>();
  List<String> elementosDropDown = [
    "Términos",
    "Aceptar términos",
    "No aceptar términos",
  ];
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Debe introducir el email";
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Introduzca su email"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Debe introducir el login";
                    }
                    if (value == "admin") {
                      return "No se puede usar ese usuario";
                    }
                  },
                  decoration: InputDecoration(label: Text("Login")),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return "Debe introducir la contraseña";
                    } else if (value.length < 8) {
                      return "La contraseña debe contener al menos 8 caracteres";
                    }
                    if(!RegExp(r'^[!@#$%&/()_-:{}].{8,}$').hasMatch(value)){

                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(label: Text("Contraseña")),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Confirmar contraseña"),
                  ),
                ),
              ),
              Container(
                child: DropdownButton<String>(
                  hint: Text(elementosDropDown.first),
                  items: elementosDropDown.map((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                  onChanged: (value) => print(value),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Enviar")),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Borrar datos"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
