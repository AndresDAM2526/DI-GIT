import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  Future<List<dynamic>?> response = getResponse();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: getResponse(),
          builder: (context, snapshot) {  //snapshot controla el estado del future, con .data obtenemos los datos que devuelve el future
            List<dynamic> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                return Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(color: Colors.red),
                  ),
                  child: ListTile(
                    leading: Text(post['userId'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber),),
                    title: Text(post['title']),
                    subtitle: Text(post['body']),
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

Future<List<dynamic>?> getResponse() async {
  var url = Uri.http('jsonplaceholder.typicode.com', '/posts');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    return jsonResponse;
  } else {
    return null;
  }
}
