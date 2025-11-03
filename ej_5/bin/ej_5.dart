/*
  Utiliza la libreía http para realizar una petición GET a una API pública(como JSONPlaceHolder).
  Usa async y await para manejar la respuestas asíncrona y muestra los datos en consola
*/

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() async {
  List<dynamic>? response= await peticionGet();
  print("UserID: ${response?[0]['userId']}");
  print("ID:${response?[0]['id']}");
  print("Title: ${response?[0]['title']}");
  print("Body: ${response?[0]['body']}");
}

Future<List<dynamic>?> peticionGet() async {
  var url =
      Uri.http('jsonplaceholder.typicode.com', '/posts');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print("Ha funcionado");
    var jsonResponse =
        convert.jsonDecode(response.body) as List<dynamic> ;
    
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}


