/**
 * Modelo que gestiona la transaccion
 */
class TransaccionModel {
  ///Atributo que define el valor inicial
  double valorInicial;
  ///Atributo que define la unidad inicial
  String unidadInicial;
  ///Atributo que define la unidad final
  String unidadFinal;
  ///Atributo que define el valor final
  double valorFinal;

  TransaccionModel({
    required this.valorInicial,
    required this.unidadInicial,
    required this.unidadFinal,
    required this.valorFinal,
  });
}
