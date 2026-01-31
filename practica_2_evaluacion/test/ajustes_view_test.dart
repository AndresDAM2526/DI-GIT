import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica_2_evaluacion/l10n/app_localizations.dart';
import 'package:practica_2_evaluacion/view/ajustes_view.dart';
import 'package:practica_2_evaluacion/viewmodel/tema_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
    'La pantalla de Ajustes muestra los controles de personalización',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('es'), // Español
            Locale('en'), // Inglés
          ],
          locale: Locale('es'),
          home: ChangeNotifierProvider(
            create: (context) => TemaViewmodel(),
            child: Ajustes(),
          ),
        ),
      );

      //AppBar
      expect(find.text('Ajustes'), findsOneWidget);
      //Switch modoOscuro
      expect(find.byType(Switch), findsOneWidget);
      //Slider tamaño de texto
      expect(find.byType(Slider), findsOneWidget);
    },
  );
}
