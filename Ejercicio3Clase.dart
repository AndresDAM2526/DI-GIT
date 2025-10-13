/*
    Define un Map que contenga pares clave-valor donde las claves sean los nombre de personas y los valores sean la edad.Escribe
    una función que sume todas las edades en el mapa y retorne el total. Luego, crea otra función que determine cual es la edad máxima y mínima en el mapa.
    Imprime los resultados
*/

class Persona{
  Map<String,int> usuarios={};
  Persona(this.usuarios);

  void edadMaxima(){
    int max=0;
    for(int edad in usuarios.values){
      if(edad>max){
        max=edad;
      }
    }
    print("La edad máxima es $max");
  }

  void edadMinima(){
    int min=usuarios.values.first;
    for(int edad in usuarios.values){
      if(edad<min){
        min=edad;
      }
    }
    print("La edad mínima es $min");
  }

}

void main(){
  Map<String,int> usuarios={"Sara":24,"Luis":18,"Pedro":35,"Marta":28};
  Persona p1=Persona(usuarios);
  p1.edadMaxima();
  p1.edadMinima();
}