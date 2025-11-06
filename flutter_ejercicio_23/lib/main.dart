import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PantallaPrincipal(nombre: 'Invitado'));
  }
}

class PantallaPrincipal extends StatefulWidget {
  String? nombre;
  PantallaPrincipal({super.key, required this.nombre});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  String nombre = "Invitado";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Hola $nombre"),
          ElevatedButton(
            onPressed: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormularioNombre()),
              );
              setState(() {
                nombre = resultado;
              });
            },
            child: Text("Ir al formulario"),
          ),
        ],
      ),
    );
  }
}

class FormularioNombre extends StatefulWidget {
  FormularioNombre({super.key});

  @override
  State<FormularioNombre> createState() => _FormularioNombreState();
}

class _FormularioNombreState extends State<FormularioNombre> {
  TextEditingController? controlador = TextEditingController();
  String nombre = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: controlador,
            onChanged: (texto) => nombre = texto,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, nombre);
            },
            child: Text("Volver a la página principal"),
          ),
        ],
      ),
    );
  }
}
