// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'Formulario de contacto';

  @override
  String get name => 'Nombre';

  @override
  String get labelName => 'Nombre';

  @override
  String get hintName => 'Introduce el nombre';

  @override
  String get email => 'Correo';

  @override
  String get labelEmail => 'Correo';

  @override
  String get hintEmail => 'Introduce el nombre';

  @override
  String get tf => 'Teléfono';

  @override
  String get labelTf => 'Teléfono';

  @override
  String get hintTf => 'Introduce el teléfono';

  @override
  String get submit => 'Enviar';

  @override
  String get clear => 'Limpiar';
}
