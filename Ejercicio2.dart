//Programa una calculadora básica.
//El usuario debe elegir una operación de un menú,introducir los diferentes números necesarios, y saldra por pantalla
//la operación adecuada

import 'dart:io';

void main(){
    String? strOpcionUsuario;
    String? strNum1;
    String? strNum2;
    int opcionUsuario;
    int num1;
    int num2;
    do {
      mostrarMenu();
      strOpcionUsuario=stdin.readLineSync();
      opcionUsuario=int.parse(strOpcionUsuario!);
      switch(opcionUsuario){
        case 1:{
          print("Introduzca el primer número:");
          strNum1=stdin.readLineSync();
          print(("Introduzca el segundo número"));
          strNum2=stdin.readLineSync();
          num1=int.parse(strNum1!);
          num2=int.parse(strNum2!);
          int suma=num1+num2;
          print("$num1 + $num2= $suma");
          break;
        }
        case 2:{
          print("Introduzca el primer número:");
          strNum1=stdin.readLineSync();
          print(("Introduzca el segundo número"));
          strNum2=stdin.readLineSync();
          num1=int.parse(strNum1!);
          num2=int.parse(strNum2!);
          int resta=num1+num2;
          print("$num1 - $num2= $resta");
          break;
        }
        case 3:{
          print("Introduzca el primer número:");
          strNum1=stdin.readLineSync();
          print(("Introduzca el segundo número"));
          strNum2=stdin.readLineSync();
          num1=int.parse(strNum1!);
          num2=int.parse(strNum2!);
          int multi=num1+num2;
          print("$num1 * $num2= $multi");
          break;
        }
        case 4:{
          print("Introduzca el primer número:");
          strNum1=stdin.readLineSync();
          print(("Introduzca el segundo número"));
          strNum2=stdin.readLineSync();
          num1=int.parse(strNum1!);
          num2=int.parse(strNum2!);
          int divison=num1+num2;
          print("$num1 / $num2= $divison");
          break;
        }
        case 5:{
          print("Saliendo ....");
          break;
        }
        default:{
          print("Opción incorrecta");
          break;
        }
      }
    } while (opcionUsuario!=5);
}

void mostrarMenu(){
  print("Calculadora hecha con DART");
  print("1-Suma");
  print("2-Resta");
  print("3-Multiplicación");
  print("4-División");
  print("5-Salir");
  print("Elija una opción:");
}