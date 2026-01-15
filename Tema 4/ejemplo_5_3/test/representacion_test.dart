import 'package:ejemplo_5_3/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Los textos funcionan correctamente", (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text("0"), findsOneWidget);
    expect(find.text("Flutter Demo Home Page"), findsOneWidget);
  });

  testWidgets("El botón funciona correctamente", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: MyHomePage(title: "prueba")),
      ),
    );
    await tester.tap(find.byType(FloatingActionButton));
  });
}
