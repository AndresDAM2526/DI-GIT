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
  List<Widget> navegacion = [
    Generar(),
    Feed(tema: '', posts: 0, hashtag: '', autor: ''),
    Opciones(),
  ];

  int pagSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pagSeleccionada,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_sharp),
              label: "Generar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_sharp),
              label: "Feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_option_key_sharp),
              label: "Opciones",
            ),
          ],
          onTap: (value) {
            setState(() {
              pagSeleccionada = value;
            });
          },
        ),
        body: navegacion[pagSeleccionada],
      ),
    );
  }
}

class Generar extends StatefulWidget {
  Generar({super.key});

  @override
  State<Generar> createState() => _GenerarState();
}

class _GenerarState extends State<Generar> {
  List<String> temas = ["Tecnología", "Juegos", "Deportes"];
  String? temaSeleccionado;
  TextEditingController? posts = TextEditingController();
  TextEditingController? hashtag = TextEditingController();
  TextEditingController? autor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Card(
                child: Column(
                  children: [
                    Row(children: [Text("Tema")]),
                    DropdownButtonFormField(
                      hint: Text("Seleccione un tema"),
                      items: temas.map((String valor) {
                        return DropdownMenuItem(
                          value: valor,
                          child: Text(valor),
                        );
                      }).toList(),
                      onChanged: (value) {
                        temaSeleccionado = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: Column(
                  children: [
                    Row(children: [Text("Número de posts[1-20]")]),
                    TextFormField(
                      controller: posts,
                      decoration: InputDecoration(
                        label: Text("Numero de posts"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: Column(
                  children: [
                    Row(children: [Text("Hashtag(opcional.ej #Flutter)")]),
                    TextFormField(
                      controller: hashtag,
                      decoration: InputDecoration(label: Text("Hashtag")),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [Text("Autor preferido(opcional ej @rodrigo)")],
                    ),
                    TextFormField(
                      controller: autor,
                      decoration: InputDecoration(label: Text("Autor")),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Feed(
                          tema: temaSeleccionado!,
                          posts: int.parse(posts!.text),
                          hashtag: hashtag!.text,
                          autor: autor!.text,
                        ),
                      ),
                    );
                  },
                  child: Text("Generar feed"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Feed extends StatefulWidget {
  String tema;
  int posts;
  String hashtag;
  String autor;
  Feed({
    super.key,
    required this.tema,
    required this.posts,
    required this.hashtag,
    required this.autor,
  });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<String> deportes = [
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
    "Ganó el Madrid",
  ];
  List<String> juegos = [
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
    "Se retrasa el GTA VI",
  ];
  List<String> tecnologia = [
    "Nuevo Iphone",
    "Nuevo Iphone",
    "Nuevo Iphone",
    "Nuevo Iphone",
    "Nuevo Iphone",
    "Nuevo Iphone",
    "Nuevo Iphone",
    "Nuevo Iphone",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Feed"))),
      body: widget.posts == 0
          ? Center(child: Text("No hay datos"))
          : ListView.builder(
              itemCount: widget.posts,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.heart_broken_outlined),
                        title: Text("${deportes[index]} #${widget.hashtag}"),
                        subtitle: widget.autor.isNotEmpty
                            ? Text(widget.autor)
                            : Text("Default"),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class Opciones extends StatefulWidget {
  Opciones({super.key});

  @override
  State<Opciones> createState() => _OpcionesState();
}

class _OpcionesState extends State<Opciones> {
  List<String> idiomas = ["Español", "Ingles", "Aleman"];

  String idiomaSeleccionado = "";
  bool estadoSwitch = false;
  double valorSlider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.wordpress),
                      Text(
                        "Idioma",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButton(
                          hint: Text("Español"),
                          items: idiomas.map((String valor) {
                            return DropdownMenuItem<String>(
                              value: valor,
                              child: Text(valor),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              idiomaSeleccionado != value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Tema oscuro",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child: Switch(
                        value: estadoSwitch,
                        onChanged: (value) {
                          setState(() {
                            estadoSwitch = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Card(
              child: Column(
                children: [
                  Text(
                    "Tamaño de texto ${valorSlider.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: valorSlider,
                    onChanged: (value) {
                      setState(() {
                        valorSlider = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
