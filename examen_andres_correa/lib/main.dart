import 'dart:ffi';

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
  final List<Widget> paginas = [
    Generar(),
    Feed(posts: 0, tema: "", autor: "", hashtag: ""),
    Opciones(),
  ];
  int paginaSeleccionada = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              paginaSeleccionada = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: "Generar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: "Feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Opciones",
            ),
          ],
        ),
        body: paginas[paginaSeleccionada],
      ),
    );
  }
}

//Pantalla de generar
class Generar extends StatefulWidget {
  @override
  State<Generar> createState() => _GenerarState();
}

class _GenerarState extends State<Generar> {
  List<String> temas = ["Tecnología", "Juegos", "Deportes"];
  String temaSeleccionado = "";
  final TextEditingController? tema = TextEditingController();
  final TextEditingController? post = TextEditingController();
  final TextEditingController? hashtag = TextEditingController();
  final TextEditingController? autor = TextEditingController();
  final _validadFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _validadFormulario,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tema", style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField(
                  hint: Text("Seleccione una opcion"),

                  items: temas.map((String valor) {
                    return DropdownMenuItem(value: valor, child: Text(valor));
                  }).toList(),
                  onChanged: (value) => setState(() {
                    temaSeleccionado = value!;
                  }),
                ),
                Text(
                  "Numero de posts [1-20]",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: post,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Seleccione el número de posts";
                    }
                  },
                  decoration: InputDecoration(label: Text("Numero de posts")),
                ),
                Text(
                  "Hastag(opcional,ej #Flutter)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: hashtag,
                  validator: (value) {
                    if (!RegExp(r'^#[A-Za-z0-9_]{2,20}$').hasMatch(value!)) {
                      return "El texto no contiene un #";
                    }
                  },
                  decoration: InputDecoration(label: Text("Hashtag")),
                ),
                Text(
                  "Autor preferido(opcional,ej @rodrigo)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: autor,
                  validator: (value) {
                    if (!RegExp(r'^@[A-Za-z0-9_]{2,20}$').hasMatch(value!)) {
                      return "El autor debe contener un @ al principio";
                    }
                  },
                  decoration: InputDecoration(label: Text("Autor")),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_validadFormulario.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Feed(
                                  posts: int.parse(post!.text),
                                  tema: temaSeleccionado,
                                  hashtag: hashtag!.text,
                                  autor: autor!.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Generar feed"),
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

//Pantalla Feed
class Feed extends StatefulWidget {
  int posts;
  String tema;
  String hashtag;
  String autor;
  Feed({
    super.key,
    required this.posts,
    required this.tema,
    required this.hashtag,
    required this.autor,
  });
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<String> Tecnologia = [
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
    "La salida del último Iphone",
  ];
  List<String> Juegos = [
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
    "Nuevo juego de Pokemon",
  ];
  final List<String> Deportes = [
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
    "Gana el Madrid",
  ];

  @override
  Widget build(BuildContext context) {
    bool pulsado = false;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Feed"))),
      body: widget.posts == 0 && widget.tema == "" && widget.hashtag == ""
          ? Center(child: Text("No hay datos"))
          : ListView.builder(
              itemCount: widget.posts,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  child: Card(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        pulsado = !pulsado;
                        print(pulsado);
                        print(widget.tema);
                        print(widget.autor);
                      }),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(Deportes[index].toString()),
                                  Text(widget.autor),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: pulsado
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        title: Text(
                          "${Deportes[index]}. ${widget.hashtag}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(widget.autor),
                        trailing: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

//Pantalla opciones
class Opciones extends StatefulWidget {
  @override
  State<Opciones> createState() => _OpcionesState();
}

class _OpcionesState extends State<Opciones> {
  double valor = 0;
  String? idiomaSeleccionado;
  List<String> idiomas = ["Español", "Inglés", "Alemán"];
  bool modoOscuro = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.language),
                        Text(
                          "Idioma",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child: DropdownButton(
                        hint: Text(idiomas.first),
                        items: idiomas.map((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: Text(valor),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            idiomaSeleccionado = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tema oscuro",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child: Switch(
                        value: modoOscuro,
                        onChanged: (value) {
                          setState(() {
                            modoOscuro = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tamaño de texto: $valor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Center(child: LinearProgressIndicator(value: valor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
