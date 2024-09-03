import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:plc_controller/model/mqtt_client_config.dart';

class MqttCLientProvider extends ChangeNotifier {

  MqttServerClient? _client;
  String _pubTopic = '';
  String _subTopic = '';
  Map<String, dynamic>? payload;
  int telemetryCounter = 0;
  DateTime? lastTelemetryReceived;

  _onData(List<MqttReceivedMessage<MqttMessage>> c) {
    final recMess = c[0].payload as MqttPublishMessage;
    final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    payload = json.decode(pt);
    telemetryCounter++;
    lastTelemetryReceived = DateTime.now();
    notifyListeners();
  }

  clearTelemetry() {
    telemetryCounter = 0;
    lastTelemetryReceived = null;
    notifyListeners();
  }

  bool isOnline() {
    return getState() == MqttConnectionState.connected;
  }

  send(Map<String, dynamic> payload){
    final builder = MqttClientPayloadBuilder();
    builder.addString(jsonEncode(payload));
    // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!
    _client?.publishMessage(_pubTopic, MqttQos.atLeastOnce, builder.payload!);
    notifyListeners();
  }

  MqttConnectionState getState() {
    if(_client != null && _client!.connectionStatus != null) {
      return _client!.connectionStatus!.state;
    }
    return MqttConnectionState.disconnected;
  }

  disconnect() {
    _client?.disconnect();
    payload = null;
    notifyListeners();
  }

  connect({
    required MqttClientConfig config
  }) async {
    notifyListeners();
    print(config);

    _client = MqttServerClient.withPort(config.brokerAddress, config.deviceName, config.port);
    if( _client != null) {
      MqttServerClient client = _client!;
      client.secure = true;
      client.keepAlivePeriod = 20;
      client.setProtocolV311();
      final SecurityContext context = SecurityContext(withTrustedRoots: false);
      context.setTrustedCertificatesBytes(utf8.encode(config.rootCACertificate));
      context.useCertificateChainBytes(utf8.encode(config.clientCertificate));
      context.usePrivateKeyBytes(utf8.encode(config.privateKey));
      client.securityContext = context;
      _pubTopic = config.pubTopic;
      _subTopic = config.subTopic;

      // Setup the connection Message
      final connMess = MqttConnectMessage()
          .withClientIdentifier('<your_client_id>')
          .startClean();
      client.connectionMessage = connMess;

      // Connect the client
      try {
        print('MQTT client connecting to AWS IoT using certificates....');
        await client.connect();
      } on Exception catch (e) {
        print('MQTT client exception - $e');
        client.disconnect();
      }

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        print('MQTT client connected to AWS IoT');
        if (_subTopic.isNotEmpty) {
          client.subscribe(config.subTopic, MqttQos.atLeastOnce);
          client.updates!.listen(_onData);
        }
      } else {
        print(
            'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
        client.disconnect();
      }
    }
    notifyListeners();
  }
}
