//Programa una calculadora básica.
//El usuario debe elegir una operación de un menú,introducir los diferentes números necesarios, y saldra por pantalla
//la operación adecuada

import 'dart:io';

class Calculadora{
  int num1;
  int num2;

  Calculadora(this.num1,this.num2);

  int suma(int num1,int num2){
    return num1+num2;
  }

  int resta(int num1,int num2){
    return num1-num2;
  }

  int multiplicacion(int num1,int num2){
    return num1*num2;
  }

  double division(int num1,int num2){
    return num1/num2;
  }
}

void main(){
  print("Introduzca el primer número:");
  String? strNum1=stdin.readLineSync();
  int num1=int.parse(strNum1!);
  print("Introduzca el segundo número:");
  String? strNum2=stdin.readLineSync();
  int num2=int.parse(strNum2!);
  Calculadora cal=Calculadora(num1, num2); 

  int suma=cal.suma(num1, num2);
  print("La suma es $suma");
    
  int resta=cal.resta(num1, num2);
  print("La resta es $resta");

  int mul=cal.resta(num1, num2);
  print("La multiplicación es $mul");

  int division=cal.resta(num1, num2);
  print("La división es $division");

}

void menu(){
  print("Calculadora hecha con DART");
  print("1-Suma");
  print("2-Resta");
  print("3-Multiplicación");
  print("4-División");
  print("5-Salir");
  print("Elija una opción:");
}