import 'package:flutter_test/flutter_test.dart';
import 'package:practica_2_evaluacion/viewmodel/formulario_viewmodel.dart'; // Ajusta la ruta

void main() {
  late FormularioViewmodel viewModel;

  setUp(() {
    viewModel = FormularioViewmodel();
  });

  group('Pruebas de Validación de Formulario', () {
    
    // --- Validación de Nombre ---
    test('validarNombre devuelve error si está vacío', () {
      expect(viewModel.validarNombre(""), "Introduzca un nombre");
    });

    test('validarNombre devuelve null si es válido', () {
      expect(viewModel.validarNombre("Teclado Mecánico"), null);
    });

    // --- Validación de Categoría ---
    test('validarCategoria devuelve error si es null', () {
      expect(viewModel.validarCategoria(null), "Seleccione una categoria");
    });

    test('validarCategoria devuelve null si es válida', () {
      expect(viewModel.validarCategoria("Electrónica"), null);
    });

    // --- Validación de Cantidad ---
    test('validarCantidad devuelve error si está vacío', () {
      expect(viewModel.validarCantidad(""), "Cantidad vacia");
    });

    test('validarCantidad devuelve error si no es un número entero', () {
      expect(viewModel.validarCantidad("abc"), "Formato de cantidad incorrecto");
      expect(viewModel.validarCantidad("10.5"), "Formato de cantidad incorrecto");
    });

    test('validarCantidad devuelve null si es un entero válido', () {
      expect(viewModel.validarCantidad("25"), null);
    });

    // --- Validación de Precio ---
    test('validarPrecio devuelve error si está vacío', () {
      expect(viewModel.validarPrecio(""), "Precio vacio");
    });

    test('validarPrecio devuelve error si el formato es incorrecto', () {
      expect(viewModel.validarPrecio("diez euros"), "Formato de precio incorrecto");
    });

    test('validarPrecio devuelve null si es un número (int o double) válido', () {
      expect(viewModel.validarPrecio("99.99"), null);
      expect(viewModel.validarPrecio("100"), null);
    });
  });
}