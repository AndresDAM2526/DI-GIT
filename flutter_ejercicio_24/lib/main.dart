import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: InicioSesion(),);
  }
}

class InicioSesion extends StatefulWidget {
  InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  String usuario = "";
  String pass = "";
  TextEditingController usuarioControlador = TextEditingController();
  TextEditingController passControlador = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Usuario"),
          TextFormField(
            controller: usuarioControlador,
            onChanged: (value) => usuario = value,
            
          ),
          Text("Contraseña"),
          TextFormField(
            controller: passControlador,
            onChanged: (value) => pass = value,
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Perfil(usuario: usuario, pass: pass),
                ),
              );
            },
            child: Text("Iniciar sesion"),
          ),
        ],
      ),
    );
  }
}

class Perfil extends StatefulWidget {
  String usuario;
  String pass;
  Perfil({super.key, required this.usuario, required this.pass});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Text("Nombre: ${widget.usuario}"),
              Text("Pass: ${widget.pass}"),
            ],
          ),
        ],
      ),
    );
  }
}
