import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url =
      Uri.https('placehold.co', '/600x400/png');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var imagen=File("imagen.png");
    imagen.writeAsBytes(response.bodyBytes);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}