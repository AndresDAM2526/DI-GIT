import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        //Locale('es')
      ],
      home: HomePage()
    );
  }
}


class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Column(
          children: [
            Form(
              child: Column(
                children: [
                  Semantics(
                    label: "Campo del nombre",
                    hint: "Campo donde se escribe el nombre",
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        child: TextFormField(
                          decoration: InputDecoration(label: Text(AppLocalizations.of(context)!.name)),
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    label: "Campo de correo electrónico",
                    hint: "Campo donde se escribe el correo electrónico",
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text(AppLocalizations.of(context)!.email),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: "Botón de enviar",
              hint: "Pulsa para enviar el formulario ",
              child: ElevatedButton(onPressed: () {}, child: Text(AppLocalizations.of(context)!.submit)),
            ),
          ],
        ),
      );
  }

}