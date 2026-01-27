import 'package:actividad_7/viewmodel/formulario_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FormularioViewmodel viewmodel;

  setUp(() {
    viewmodel = FormularioViewmodel();
  });

  test("Debería mostrar texto de Campo vacío ", () {
    final resultado = viewmodel.validarNombre("");
    expect(resultado, "Campo vacío");
  });

  test("Debería mostrar Longitud del teléfono incorrecta", () {
    final resultado = viewmodel.validarTelefono("12345678912");
    expect(resultado, "Longitud del teléfono incorrecta");
  });

  test("Debería mostrar Formato del teléfono incorrecto", () {
    final resultado = viewmodel.validarTelefono("64567896T");
    expect(resultado, "Formato del teléfono incorrecto");
  });
}
