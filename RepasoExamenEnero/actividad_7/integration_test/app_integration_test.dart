import 'package:actividad_7/main.dart' as app;
import 'package:actividad_7/view/formulario_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Se escribe un nombre y un telefono y se envia el formulario", (
    WidgetTester tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), "Andres");
    await tester.enterText(find.byType(TextFormField).at(1), "678956785");

    final btnEnviar = find.widgetWithText(ElevatedButton, "Enviar");
    await tester.tap(btnEnviar);

    await tester.pumpAndSettle();
    expect(find.text("Enviado"), findsOneWidget);
  });
}
