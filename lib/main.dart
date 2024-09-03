import 'package:flutter/material.dart';
import 'package:plc_controller/pages/home_page.dart';
import 'package:plc_controller/provider/mqtt_client_provider.dart';
import 'package:plc_controller/provider/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesProvider preferencesProvider = PreferencesProvider();
  await preferencesProvider.init();
  runApp(MultiProvider(
    providers: [
      ListenableProvider<MqttCLientProvider>(
          create: (_) => MqttCLientProvider()),
      ListenableProvider<PreferencesProvider>(
          create: (_) => preferencesProvider),
    ],
    builder: (context, child) {
      return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            // colorScheme: ColorScheme.fromSeed(
            //   seedColor: Colors.tealAccent,
            //   brightness: Brightness.dark,
            // ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: HomePage());
    },
  ));
}
