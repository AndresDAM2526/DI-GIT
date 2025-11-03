import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    return "Ingrese su nombre";
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (correo) {
                    if (correo!.isEmpty) {
                      return "Ingrese su correo";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Correo electrónico",
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (pass) {
                    if (pass!.length < 8) {
                      return "La contraseña debe tener mínimo 8 caracteres";
                    }
                  },
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Formaulario correcto");
                  } else {
                    print("Error");
                  }
                },
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
