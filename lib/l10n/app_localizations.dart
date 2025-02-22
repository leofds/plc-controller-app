import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PLC Controller'**
  String get appTitle;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuAbout;

  /// No description provided for @homePageConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get homePageConnect;

  /// No description provided for @homePageDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get homePageDisconnect;

  /// No description provided for @homePageStateOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get homePageStateOnline;

  /// No description provided for @homePageStateOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get homePageStateOffline;

  /// No description provided for @homePageStateFailure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get homePageStateFailure;

  /// No description provided for @homePageOutput.
  ///
  /// In en, this message translates to:
  /// **'Output'**
  String get homePageOutput;

  /// No description provided for @homePageKeys.
  ///
  /// In en, this message translates to:
  /// **'Keys'**
  String get homePageKeys;

  /// No description provided for @homePageTelemetry.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get homePageTelemetry;

  /// No description provided for @homePageTelemetryCounter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get homePageTelemetryCounter;

  /// No description provided for @homePageTelemetryClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get homePageTelemetryClear;

  /// No description provided for @homePageKeyOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get homePageKeyOff;

  /// No description provided for @homePageKeyOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get homePageKeyOn;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @settingsPageBrokerAddress.
  ///
  /// In en, this message translates to:
  /// **'Broker Address'**
  String get settingsPageBrokerAddress;

  /// No description provided for @settingsPageDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get settingsPageDeviceName;

  /// No description provided for @settingsPagePort.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get settingsPagePort;

  /// No description provided for @settingsPagePublishTopic.
  ///
  /// In en, this message translates to:
  /// **'Publish Topic'**
  String get settingsPagePublishTopic;

  /// No description provided for @settingsPageSubscribeTopic.
  ///
  /// In en, this message translates to:
  /// **'Subscribe Topic'**
  String get settingsPageSubscribeTopic;

  /// No description provided for @settingsPageRootCACertificate.
  ///
  /// In en, this message translates to:
  /// **'Root CA Certificate'**
  String get settingsPageRootCACertificate;

  /// No description provided for @settingsPageClientCertificate.
  ///
  /// In en, this message translates to:
  /// **'Client Certificate'**
  String get settingsPageClientCertificate;

  /// No description provided for @settingsPagePrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Private Key'**
  String get settingsPagePrivateKey;

  /// No description provided for @settingsPageClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsPageClear;

  /// No description provided for @aboutPageTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutPageTitle;

  /// No description provided for @aboutPageVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutPageVersion;

  /// No description provided for @appLicense.
  ///
  /// In en, this message translates to:
  /// **'MIT License\n\nCopyright (c) 2024 Leonardo Fernandes\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.'**
  String get appLicense;

  /// No description provided for @appProjectLink.
  ///
  /// In en, this message translates to:
  /// **'https://github.com/leofds/plc-controller'**
  String get appProjectLink;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
