import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  Future<List<dynamic>?> response = getResponse();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        body: FutureBuilder(
          future: getResponse(),
          builder: (context, snapshot) {
            List<dynamic> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                return Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Text(post['id'].toString()),
                    title: Text(post['title']),
                    subtitle: Text(post['body']),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Informacion(
                              id: post['id'].toString(),
                              title: post['title'],
                              body: post['body'],
                            ),
                          ),
                        );
                      },
                      child: Text("Informacion"),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Informacion extends StatelessWidget {
  String id;
  String title;
  String body;

  Informacion({
    super.key,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(id),
          Text(title),
          Text(body),
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

Future<List<dynamic>?> getResponse() async {
  var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    return jsonResponse;
  } else {
    print("Error al cargar los datos");
  }
}
