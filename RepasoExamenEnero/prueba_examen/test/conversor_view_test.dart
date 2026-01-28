import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:prueba_examen/l10n/app_localizations.dart';
import 'package:prueba_examen/view/conversor_view.dart';
import 'package:prueba_examen/viewmodel/conversor_viewmodel.dart';
import 'package:prueba_examen/viewmodel/database_viewmodel.dart';
import 'package:prueba_examen/viewmodel/tema_viewmodel.dart';

void main() {
  testWidgets("El widget muestra el botón", (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DatabaseViewmodel()),
          ChangeNotifierProvider(create: (context) => ConversorViewmodel()),
          ChangeNotifierProvider(create: (context) => TemaViewmodel()),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('es'), Locale('en')],
          home: ConversorView(),
        ),
      ),
    );
    final boton = find.byType(ElevatedButton);
    expect(boton, findsOneWidget);
  });
}
