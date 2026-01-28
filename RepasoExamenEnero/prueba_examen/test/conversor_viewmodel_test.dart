import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_examen/viewmodel/conversor_viewmodel.dart';

void main() {
  late ConversorViewmodel conversorViewmodel;

  setUp(() {
    conversorViewmodel = ConversorViewmodel();
  });

  test("Debería mostrar texto El formato del número es incorrecto", () {
    final resultado = conversorViewmodel.validarValor("12A");
    expect(resultado, "El formato del número es incorrecto");
  });
}
