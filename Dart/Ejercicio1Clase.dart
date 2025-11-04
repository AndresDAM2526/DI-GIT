//Genera una lista de números primos hasta el que el usuario introduzca por consola
import 'dart:io';

class NumPrimos{
  int num1;

  NumPrimos(this.num1);

  void numerosPrimos(){
    List<int> numeros=[];
    int aux=1;
    int contador=0;
    while(aux<=this.num1){
      contador=0;
      for(int i=1;i<=aux;i++){
        if(aux%i==0){
          contador++;
        }
      }
      if(contador==2 || contador==1){
        numeros.add(aux);
      }
      aux++;
    }
    print(numeros);
  }
}

void main(){
  try{
    print("Introduzca un número");
    String? strNumero=stdin.readLineSync();
    int num=int.parse(strNumero!);
    NumPrimos n1=NumPrimos(num);
    n1.numerosPrimos();
  }catch(e){
    print("Error: $e");
  }
}