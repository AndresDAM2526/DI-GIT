/*
  Utiliza la libreía http para realizar una petición GET a una API pública(como JSONPlaceHolder).
  Usa async y await para manejar la respuestas asíncrona y muestra los datos en consola
*/

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() async {
  var url =
      Uri.http('jsonplaceholder.typicode.com', '/posts',{'id':'1'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print("Ha funcionado");
    var jsonResponse =
        convert.jsonDecode(response.body) ;
    
    print(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}


