/*
    Define un Map que contenga pares clave-valor donde las claves sean los nombre de personas y los valores sean la edad.Escribe
    una función que sume todas las edades en el mapa y retorne el total. Luego, crea otra función que determine cual es la edad máxima y mínima en el mapa.
    Imprime los resultados
*/

void main(){
    Map<String,int> usuarios={"Sara":24,"Luis":18,"Pedro":35,"Marta":28};
    totalEdades(usuarios);


}

void totalEdades(Map<String,int> mapa){
    int suma=0;
    for(int clave in mapa.values){
      suma+=clave;
    }

    print("La suma de todas las edades es: $suma");
    edadMaxima(mapa);
    edadMinima(mapa);
}

void edadMaxima(Map<String,int> mapa){
  int max=0;

  for(int clave in mapa.values){
    if(clave>=max){
      max=clave;
    }
  }

  print("La edad máxima es $max");
}

void edadMinima(Map<String,int> mapa){
  int min=10000;
  for(int clave in mapa.values){
    if(clave<min){
      min=clave;
    }
  }
  print("La edad mínima es $min");
}