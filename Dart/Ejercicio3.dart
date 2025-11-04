/*
    Define un Map que contenga pares clave-valor donde las claves sean los nombre de personas y los valores sean la edad.Escribe
    una función que sume todas las edades en el mapa y retorne el total. Luego, crea otra función que determine cual es la edad máxima y mínima en el mapa.
    Imprime los resultados
*/

void main(){
    Map<String,int> usuarios={"Sara":24,"Luis":18,"Pedro":35,"Marta":28};
    totalEdades(usuarios);
    print("La edad máxima es ${edadMaxima(usuarios)}");
    print("La edad mínima es ${edadMinima(usuarios)}");


}

void totalEdades(Map<String,int> mapa){
    int suma=0;
    for(int clave in mapa.values){
      suma+=clave;
    }

    print("La suma de todas las edades es: $suma");

}

int edadMaxima(Map<String,int> mapa){
  int max=mapa.values.first;

  for(int clave in mapa.values){
    if(clave>=max){
      max=clave;
    }
  }

  return max;
}

int edadMinima(Map<String,int> mapa){
  int min=mapa.values.first;
  for(int clave in mapa.values){
    if(clave<min){
      min=clave;
    }
  }
  return min;
}