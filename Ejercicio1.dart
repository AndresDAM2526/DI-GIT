import 'dart:io';

void main(){
 //Genera una lista de números primos hasta el que el usuario introduzca por consola
 List<int> primos=[];
 print("Introduzca un numero");
 String? strNumUsuario=stdin.readLineSync();
 int numMaximo=int.parse(strNumUsuario!);
 int aux=1;
 int contador=0;
 while(aux<=numMaximo){
  contador=0;
  for(int i=1;i<=aux;i++){
    if(aux%i==0){
      contador++;
    }
  }
  if(contador==2|| contador==1){
    primos.add(aux);
  }
  aux++;
 }

 print("$primos");
 
}