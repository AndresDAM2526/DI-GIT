// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Contacto Form';

  @override
  String get name => 'Name';

  @override
  String get labelName => 'Name';

  @override
  String get hintName => 'Write your name';

  @override
  String get email => 'Email';

  @override
  String get labelEmail => 'Email';

  @override
  String get hintEmail => 'Write your email';

  @override
  String get tf => 'Telephone';

  @override
  String get labelTf => 'Telephone';

  @override
  String get hintTf => 'Write your telephone';

  @override
  String get submit => 'Submit';

  @override
  String get clear => 'Clear';
}
