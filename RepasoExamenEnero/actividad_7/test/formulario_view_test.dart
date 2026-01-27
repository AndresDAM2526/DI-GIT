import 'package:actividad_7/main.dart';
import 'package:actividad_7/view/formulario_view.dart';
import 'package:actividad_7/viewmodel/formulario_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("El widget muestra el título", (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => FormularioViewmodel(),
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text("Formulario de registro")),
            body: FormularioView(),
          ),
        ),
      ),
    );
    expect(find.text('Formulario de registro'), findsOneWidget);
    expect(find.textContaining("Formulario"), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump();
  });
}
