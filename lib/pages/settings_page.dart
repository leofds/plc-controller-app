import 'package:flutter/material.dart';
import 'package:plc_controller/model/mqtt_client_config.dart';
import 'package:plc_controller/provider/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  MqttClientConfig? _config;

  final _brokerAddressController = TextEditingController();
  final _deviceNameController = TextEditingController();
  final _portController = TextEditingController();
  final _caCertificateController = TextEditingController();
  final _clientCertificateController = TextEditingController();
  final _privateKeyController = TextEditingController();
  final _publishTopicController = TextEditingController();
  final _subscribeTopicController = TextEditingController();

  Future<void> _save(final BuildContext context) async {
    int port = 8883;
    try {
      port = int.parse(_portController.text);
    } catch (e) {
      print(e);
    }
    await Provider.of<PreferencesProvider>(context, listen: false).setConfig(
        MqttClientConfig(
            brokerAddress: _brokerAddressController.text,
            deviceName: _deviceNameController.text,
            port: port,
            rootCACertificate: _caCertificateController.text,
            clientCertificate: _clientCertificateController.text,
            privateKey: _privateKeyController.text,
            pubTopic: _publishTopicController.text,
            subTopic: _subscribeTopicController.text));
  }

  _pressedClear() {
    _brokerAddressController.text = '';
    _deviceNameController.text = '';
    _portController.text = '8883';
    _caCertificateController.text = '';
    _clientCertificateController.text = '';
    _privateKeyController.text = '';
    _publishTopicController.text = '';
    _subscribeTopicController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    _config ??=
        Provider.of<PreferencesProvider>(context, listen: false).getConfig();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsPageTitle),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          _save(context).then((_) {
            if (context.mounted) {
              Navigator.pop(context, result);
            }
          });
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _brokerAddressController
                          ..text = _config!.brokerAddress,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPageBrokerAddress,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _deviceNameController
                          ..text = _config!.deviceName,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPageDeviceName,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _portController
                          ..text = _config!.port.toString(),
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.settingsPagePort,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _publishTopicController
                          ..text = _config!.pubTopic,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPagePublishTopic,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _subscribeTopicController
                          ..text = _config!.subTopic,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPageSubscribeTopic,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _caCertificateController
                          ..text = _config!.rootCACertificate,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPageRootCACertificate,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _clientCertificateController
                          ..text = _config!.clientCertificate,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPageClientCertificate,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _privateKeyController
                          ..text = _config!.privateKey,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .settingsPagePrivateKey,
                            border: const OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          _pressedClear();
                        },
                        child: Text(
                            AppLocalizations.of(context)!.settingsPageClear))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
