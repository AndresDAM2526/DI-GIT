import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

/// Widget principal, página de registro
class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  /// *Variable para gestionar la validación del formulario*
  final validarFormulario = GlobalKey<FormState>();

  /// Variable de tipo TexEditingController para almacenar el email
  TextEditingController? email = TextEditingController();

  /// *Variable de tipo TexEditingController para almacenar el login*
  TextEditingController? login = TextEditingController();

  /// *Variable de tipo TexEditingController para almacenar la contraseña*
  TextEditingController? contrasena = TextEditingController();

  /// *Variable de tipo TexEditingController para almacenar la contraseña*
  TextEditingController? confirmarContrasena = TextEditingController();

  ///String
  String valorSeleccionado = "";

  ///Lista que almacena los elementos que se muestran en el DropDown
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
            key: validarFormulario,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (campoVacio(value)) {
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
                      ///Se valida que el campo del Login no esté vacio
                      if (campoVacio(value)) {
                        return "Debe introducir el login";
                      }

                      ///Se valida que el usuario no utilice el usuario admin
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
                      ///Se valida que el campo de la contraseña no esté vacio y que su longitud no sea inferior a 8 caracteres
                      if (campoVacio(value)) {
                        return "Debe introducir la contraseña";
                      } else if (value!.length < 8) {
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
                      ///Se valida que el campo de confirmar contraseña no esté vacio y que coincida con el campo Contraseña
                      if (value != contrasena!.text) {
                        return "Las contraseñas no coinciden";
                      } else if (value!.isEmpty) {
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
                      ///Se valida que el usuario haya seleccionado un elemento del DropDown
                      if (value == null || value.isEmpty) {
                        return "Debe seleccionar una opcion";
                      }
                    },
                    hint: Text("Seleccione una opción"),
                    initialValue: valorSeleccionado.isEmpty
                        ? null
                        : valorSeleccionado,
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
                          if (validarFormulario.currentState!.validate()) {
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
                            valorSeleccionado = "";
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

  ///Funcion para comprobar que un dato no esté vacio
  bool campoVacio(String? datos) {
    if (datos!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

///Widget donde se muestran los datos introducidos por el usuario
class DatosUsuario extends StatelessWidget {
  ///Email del usuario
  String email;

  ///Login del usuario
  String login;

  ///Contraseña del usuario
  String contrasena;

  ///Terminos elegidos por el usuario
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
