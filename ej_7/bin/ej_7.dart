void main(){
  int valorInicial=10;
  int valorFinal=0;
  Stream.periodic(Duration(seconds: 1),(tick)=> valorInicial-tick).takeWhile((valor)=> valor >=valorFinal).forEach((valor)=>print("Numero: $valor"));
}