import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: "Formulario de registro",
            hint: "Formulario donde se introducen los datos para registrarse",
            child: Center(child: Text("Formulario")),
          ),
        ),
        body: Column(
          children: [
            Form(
              child: Column(
                children: [
                  Semantics(
                    label: "Campo del nombre",
                    hint: "Campo donde se escribe el nombre",
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        child: TextFormField(
                          decoration: InputDecoration(label: Text("Nombre")),
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    label: "Campo de correo electrónico",
                    hint: "Campo donde se escribe el correo electrónico",
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Correo electrónico"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Botón de enviar",
              hint: "Pulsa para enviar el formulario ",
              child: ElevatedButton(onPressed: () {}, child: Text("Enviar")),
            ),
          ],
        ),
      ),
    );
  }
}
