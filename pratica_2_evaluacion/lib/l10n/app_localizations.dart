import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @bottomNavigationLabelStock.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get bottomNavigationLabelStock;

  /// No description provided for @bottomNavigationLabelInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get bottomNavigationLabelInvoices;

  /// No description provided for @bottomNavigationLabelSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottomNavigationLabelSettings;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Complete Purchase'**
  String get buy;

  /// No description provided for @stockTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stockTitle;

  /// No description provided for @tableName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get tableName;

  /// No description provided for @tableCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get tableCategory;

  /// No description provided for @tableQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get tableQuantity;

  /// No description provided for @tablePrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get tablePrice;

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get emptyCart;

  /// No description provided for @notEmptyCart.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get notEmptyCart;

  /// No description provided for @emptyCartAction.
  ///
  /// In en, this message translates to:
  /// **'Clear cart'**
  String get emptyCartAction;

  /// No description provided for @tableEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get tableEdit;

  /// No description provided for @tabledelete.
  ///
  /// In en, this message translates to:
  /// **'Delete product'**
  String get tabledelete;

  /// No description provided for @tableAddProduct.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get tableAddProduct;

  /// No description provided for @buttonAddProduct.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get buttonAddProduct;

  /// No description provided for @titleForm.
  ///
  /// In en, this message translates to:
  /// **'Add product'**
  String get titleForm;

  /// No description provided for @titleModifyForm.
  ///
  /// In en, this message translates to:
  /// **'Modify product'**
  String get titleModifyForm;

  /// No description provided for @modifyButton.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get modifyButton;

  /// No description provided for @clearFields.
  ///
  /// In en, this message translates to:
  /// **'Clear fields'**
  String get clearFields;

  /// No description provided for @nameForm.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameForm;

  /// No description provided for @selectCategoryForm.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategoryForm;

  /// No description provided for @quantityForm.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityForm;

  /// No description provided for @priceForm.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceForm;

  /// No description provided for @addButtonForm.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButtonForm;

  /// No description provided for @invoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoiceTitle;

  /// No description provided for @generatePDF.
  ///
  /// In en, this message translates to:
  /// **'Generate PDF'**
  String get generatePDF;

  /// No description provided for @setingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get fontSize;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
