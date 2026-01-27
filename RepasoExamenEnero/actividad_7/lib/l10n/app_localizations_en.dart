// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBarTitle => 'Registration Form';

  @override
  String get name => 'Name';

  @override
  String get telephone => 'Phone Number';

  @override
  String get submit => 'Submit';

  @override
  String get clear => 'Clear fields';
}
