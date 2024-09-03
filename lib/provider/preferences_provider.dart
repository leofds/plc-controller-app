import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plc_controller/model/mqtt_client_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider extends ChangeNotifier {
  final _brokerAddress = 'brokerAddress';
  final _deviceName = 'deviceName';
  final _port = 'port';
  final _rootCACertificate = 'rootCACertificate';
  final _clientCertificate = 'clientCertificate';
  final _privateKey = 'privateKey';
  final _pubTopic = 'pubTopic';
  final _subTopic = 'subTopic';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setConfig(MqttClientConfig mqttConfig) async {
    await _prefs.setString(_brokerAddress, mqttConfig.brokerAddress);
    await _prefs.setString(_deviceName, mqttConfig.deviceName);
    await _prefs.setInt(_port, mqttConfig.port);
    await _prefs.setString(_rootCACertificate, mqttConfig.rootCACertificate);
    await _prefs.setString(_clientCertificate, mqttConfig.clientCertificate);
    await _prefs.setString(_privateKey, mqttConfig.privateKey);
    await _prefs.setString(_pubTopic, mqttConfig.pubTopic);
    await _prefs.setString(_subTopic, mqttConfig.subTopic);
  }

  MqttClientConfig getConfig() {
    return MqttClientConfig(
        brokerAddress: _prefs.getString(_brokerAddress) ?? '',
        deviceName: _prefs.getString(_deviceName) ?? '',
        port: _prefs.getInt(_port) ?? 8883,
        rootCACertificate: _prefs.getString(_rootCACertificate) ?? '',
        clientCertificate: _prefs.getString(_clientCertificate) ?? '',
        privateKey: _prefs.getString(_privateKey) ?? '',
        pubTopic: _prefs.getString(_pubTopic) ?? '',
        subTopic: _prefs.getString(_subTopic) ?? '');
  }
}
