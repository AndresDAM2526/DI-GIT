/*
  Utiliza la libreía http para realizar una petición GET a una API pública(como JSONPlaceHolder).
  Usa async y await para manejar la respuestas asíncrona y muestra los datos en consola
*/

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url =
      Uri.http('jsonplaceholder.typicode.com', '/todos/1');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print("Ha funcionado");
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}