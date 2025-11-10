import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _validarFormulario = GlobalKey<FormState>();

  final TextEditingController? email = TextEditingController();

  final TextEditingController? login = TextEditingController();

  final TextEditingController? contrasena = TextEditingController();

  final TextEditingController? confirmarContrasena = TextEditingController();

  String valorSeleccionado="";

  List<String> elementosDropDown = [
    "Términos",
    "Aceptar términos",
    "No aceptar términos",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          body: Form(
            key: _validarFormulario,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
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
                    controller: login,
                    validator: (value) {
                      if (value!.isEmpty) {
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
                    controller: contrasena,
                    validator: (value) {
                      if (value == "" || value!.isEmpty) {
                        return "Debe introducir la contraseña";
                      } else if (value.length < 8) {
                        return "La contraseña debe contener al menos 8 caracteres";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(label: Text("Contraseña")),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: confirmarContrasena,
                    validator: (value) {
                      if (value != contrasena!.text) {
                        return "Las contraseñas no coinciden";
                      }else if(value!.isEmpty){
                        return "Contraseña vacia";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text("Confirmar contraseña"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return "Debe seleccionar una opcion";
                      }
                    },
                    hint: Text("Seleccione una opción"),
                    initialValue: valorSeleccionado.isEmpty?null:valorSeleccionado,
                    items: elementosDropDown.map((String valor) {
                      return DropdownMenuItem<String>(
                        value: valor,
                        child: Text(valor),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      valorSeleccionado = value!;
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_validarFormulario.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DatosUsuario(
                                  email: email!.text,
                                  login: login!.text,
                                  contrasena: contrasena!.text,
                                  terminos: valorSeleccionado!,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Enviar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          email!.clear();
                          login!.clear();
                          contrasena!.clear();
                          confirmarContrasena!.clear();
                          setState(() {
                            valorSeleccionado="";
                          });
                        },
                        child: Text("Borrar datos"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DatosUsuario extends StatelessWidget {
  String email;
  String login;
  String contrasena;
  String terminos;
  DatosUsuario({
    super.key,
    required this.email,
    required this.login,
    required this.contrasena,
    required this.terminos,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(email),
          Text(login),
          Text(contrasena),
          Text(terminos),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Volver"),
          ),
        ],
      ),
    );
  }
}
