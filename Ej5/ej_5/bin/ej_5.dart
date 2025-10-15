/*
  Utiliza la libreía http para realizar una petición GET a una API pública(como JSONPlaceHolder).
  Usa async y await para manejar la respuestas asíncrona y muestra los datos en consola
*/

import 'package:http/http.dart' as http;
void main() async{
  try{
    String request= await getRequest();
    print(request);
  }catch(e){
    print("Error: $e");
  }

}

Future<String> getRequest() async{
  final url=Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
  final response= await http.get(url);

  print("Código de estado: ${response.statusCode}");

  if(response.statusCode==200){
    return response.body;
  }else{
    throw Exception("Fallo la solicitud GET");
  }
}
