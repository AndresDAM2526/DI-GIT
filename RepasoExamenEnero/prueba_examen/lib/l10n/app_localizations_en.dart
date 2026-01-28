// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get menu => 'Menu';

  @override
  String get conversor => 'Converter';

  @override
  String get transacciones => 'Transactions';

  @override
  String get ajustes => 'Settings';

  @override
  String get textoFormField => 'Enter the value';

  @override
  String get textoBoton => 'Convert and save';

  @override
  String get modoOscuro => 'Dark mode';

  @override
  String get idioma => 'Language';

  @override
  String get tamanoTexto => 'Font size';

  @override
  String get textoSnackbar => 'Transaction saved successfully';
}
