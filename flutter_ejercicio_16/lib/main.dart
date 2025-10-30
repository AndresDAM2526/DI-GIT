import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  Future<List<dynamic>?> response=getResponse();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: ListView.builder(itemBuilder: response.)),
    );
  }
}

Future<List<dynamic>?> getResponse() async {
  var url = Uri.http('jsonplaceholder.typicode.com', '/posts');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as List<dynamic>;
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return null;
  }
}
