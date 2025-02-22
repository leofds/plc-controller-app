// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PLC Controller';

  @override
  String get menuAbout => 'About';

  @override
  String get homePageConnect => 'Connect';

  @override
  String get homePageDisconnect => 'Disconnect';

  @override
  String get homePageStateOnline => 'Online';

  @override
  String get homePageStateOffline => 'Offline';

  @override
  String get homePageStateFailure => 'Failure';

  @override
  String get homePageOutput => 'Output';

  @override
  String get homePageKeys => 'Keys';

  @override
  String get homePageTelemetry => 'Telemetry';

  @override
  String get homePageTelemetryCounter => 'Counter';

  @override
  String get homePageTelemetryClear => 'Clear';

  @override
  String get homePageKeyOff => 'Off';

  @override
  String get homePageKeyOn => 'On';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsPageBrokerAddress => 'Broker Address';

  @override
  String get settingsPageDeviceName => 'Device Name';

  @override
  String get settingsPagePort => 'Port';

  @override
  String get settingsPagePublishTopic => 'Publish Topic';

  @override
  String get settingsPageSubscribeTopic => 'Subscribe Topic';

  @override
  String get settingsPageRootCACertificate => 'Root CA Certificate';

  @override
  String get settingsPageClientCertificate => 'Client Certificate';

  @override
  String get settingsPagePrivateKey => 'Private Key';

  @override
  String get settingsPageClear => 'Clear';

  @override
  String get aboutPageTitle => 'About';

  @override
  String get aboutPageVersion => 'Version';

  @override
  String get appLicense => 'MIT License\n\nCopyright (c) 2024 Leonardo Fernandes\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.';

  @override
  String get appProjectLink => 'https://github.com/leofds/plc-controller';
}
