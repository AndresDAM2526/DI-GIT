import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: obtenerPosts(),
          builder: (context, snapshot) {
              var posts=snapshot.data as List;
              return ListView.builder(itemCount: posts.length,itemBuilder: (context,index){
                var post=posts[index];
                return ListTile(
                  leading: post['id'],
                  title: post['title'],
                  subtitle: post['body'],
                )
              });
          },
        ),
      ),
    );
  }
}

Future<List> obtenerPosts() async {
  var json = await rootBundle.loadString('assets/posts.json');
  return jsonDecode(json) as List;
}
