import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:plc_controller/pages/about_page.dart';
import 'package:plc_controller/pages/settings_page.dart';
import 'package:plc_controller/provider/mqtt_client_provider.dart';
import 'package:plc_controller/provider/preferences_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum KeyState { none, on, off }

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<KeyState> _keySt = [
    KeyState.none,
    KeyState.none,
    KeyState.none,
    KeyState.none,
    KeyState.none,
    KeyState.none,
    KeyState.none,
    KeyState.none
  ];

  _pressedSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );

  }

  _pressedMenuAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPage(),
      ),
    );
  }

  _pressedConnect(BuildContext context) {
    final client = Provider.of<MqttCLientProvider>(context, listen: false);
    if (client.getState() == MqttConnectionState.connected) {
      Provider.of<MqttCLientProvider>(context, listen: false).disconnect();
      _keySt.fillRange(0, _keySt.length, KeyState.none);
    } else if (client.getState() == MqttConnectionState.disconnected) {
      final config =
          Provider.of<PreferencesProvider>(context, listen: false).getConfig();
      Provider.of<MqttCLientProvider>(context, listen: false)
          .connect(config: config);
    }
  }

  _pressedTurnOff(BuildContext context, int number) {
    Map<String, int> payload = {'MI${number.toString().padLeft(2, '0')}': 0};
    Provider.of<MqttCLientProvider>(context, listen: false).send(payload);
  }

  _pressedTurnOn(BuildContext context, int number) {
    Map<String, int> payload = {'MI${number.toString().padLeft(2, '0')}': 1};
    Provider.of<MqttCLientProvider>(context, listen: false).send(payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: Colors.white,
            child: Text(AppLocalizations.of(context)!.appTitle)),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            initialValue: 1,
            onSelected: (value) {
              _pressedMenuAbout(context);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 1,
                child: Text(AppLocalizations.of(context)!.menuAbout),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pressedSettings(context);
        },
        child: const Icon(Icons.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getConnection(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 5,
                        child: Consumer<MqttCLientProvider>(
                            builder: (context, client, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .homePageOutput,
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ),
                              for (final i
                                  in List.generate(8, (index) => index + 1))
                                _getOutput(
                                    context: context,
                                    label: 'Q$i',
                                    state: client.payload?['Q$i'] ?? 0)
                            ],
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Text(
                                  AppLocalizations.of(context)!.homePageKeys,
                                  style:
                                      const TextStyle(color: Colors.black45)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 20,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .homePageKeyOff,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .homePageKeyOn,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            for (final i in List.generate(
                                _keySt.length, (index) => index + 1))
                              _getKey(
                                  context: context,
                                  label: 'M$i',
                                  keyIndex: (i - 1),
                                  turnOffPressed: () {
                                    _pressedTurnOff(context, i);
                                  },
                                  turnOnPressed: () {
                                    _pressedTurnOn(context, i);
                                  }),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _getTelemetryInfo()
          ],
        ),
      ),
    );
  }

  _getConnectionSatus(BuildContext context, MqttConnectionState state) {
    switch (state) {
      case MqttConnectionState.disconnected:
        return Text(AppLocalizations.of(context)!.homePageStateOffline);
      case MqttConnectionState.connected:
        return Text(AppLocalizations.of(context)!.homePageStateOnline);
      case MqttConnectionState.faulted:
        return Text(AppLocalizations.of(context)!.homePageStateFailure);
      case MqttConnectionState.connecting:
      case MqttConnectionState.disconnecting:
        break;
    }
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }

  _getConnection(BuildContext context) {
    final config =
    Provider.of<PreferencesProvider>(context, listen: false).getConfig();
    return Consumer<MqttCLientProvider>(builder: (context, client, child) {
      MqttConnectionState state = client.getState();
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_getConnectionSatus(context, state)]),
            ),
            Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: (state == MqttConnectionState.connected ||
                        state == MqttConnectionState.disconnected)
                    ? () {
                        _pressedConnect(context);
                      }
                    : null,
                style: TextButton.styleFrom(
                  animationDuration: Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  state == MqttConnectionState.connected
                      ? AppLocalizations.of(context)!.homePageDisconnect
                      : AppLocalizations.of(context)!.homePageConnect,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _getOutput(
      {required BuildContext context,
      required String label,
      required int state}) {
    return Consumer<MqttCLientProvider>(builder: (context, client, child) {
      bool online = client.isOnline();
      return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: online ? Colors.black : Colors.black45),
            ),
            const SizedBox(width: 15),
            Icon(Icons.lightbulb,
                color: state == 1 ? Colors.red : Colors.grey[300])
          ],
        ),
      );
    });
  }

  _getKey(
      {required BuildContext context,
      required String label,
      required int keyIndex,
      required Function turnOffPressed,
      required Function turnOnPressed}) {
    return Consumer<MqttCLientProvider>(builder: (context, client, child) {
      bool online = client.isOnline();
      return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: online
                    ? () {
                        turnOffPressed();
                        _keySt[keyIndex] = KeyState.off;
                      }
                    : null,
                icon: Icon(_keySt[keyIndex] == KeyState.off
                    ? Icons.radio_button_on
                    : Icons.radio_button_off),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Center(
                  child: Text(
                    label,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: online ? Colors.black : Colors.black45),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: online
                      ? () {
                          turnOnPressed();
                          _keySt[keyIndex] = KeyState.on;
                        }
                      : null,
                  icon: Icon(_keySt[keyIndex] == KeyState.on
                      ? Icons.radio_button_on
                      : Icons.radio_button_off)),
            ),
          ],
        ),
      );
    });
  }

  _getTelemetryInfo() {
    return Consumer<MqttCLientProvider>(builder: (context, client, child) {
      int counter = client.telemetryCounter;
      DateTime? date = client.lastTelemetryReceived;
      String dtStr = '';
      if (date != null) {
        DateFormat df = DateFormat('HH:mm:ss yyyy/MM/dd');
        dtStr = df.format(date);
      }
      return Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.homePageTelemetry,
                  style: const TextStyle(color: Colors.black45, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  '${AppLocalizations.of(context)!.homePageTelemetryCounter}: $counter',
                  style: const TextStyle(color: Colors.black45),
                ),
                const SizedBox(height: 5),
                if (dtStr.isNotEmpty)
                  Text(
                    dtStr,
                    style: const TextStyle(color: Colors.black45),
                  ),
                const SizedBox(height: 5),
                if (dtStr.isNotEmpty)
                  TextButton(
                      onPressed: () {
                        client.clearTelemetry();
                      },
                      child: Text(
                          AppLocalizations.of(context)!.homePageTelemetryClear))
              ],
            )
          ],
        )
      ]);
    });
  }
}
