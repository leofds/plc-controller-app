class MqttClientConfig {
  late String brokerAddress;
  late String deviceName;
  late int port;
  late String rootCACertificate;
  late String clientCertificate;
  late String privateKey;
  late String pubTopic;
  late String subTopic;

  MqttClientConfig(
      {required this.brokerAddress,
      required this.deviceName,
      required this.port,
      required this.rootCACertificate,
      required this.clientCertificate,
      required this.privateKey,
      required this.pubTopic,
      required this.subTopic});

  @override
  String toString() {
    return 'MqttClientConfig (brokerAddress: $brokerAddress, deviceName: $deviceName, port: $port, rootCACertificate: $rootCACertificate, clientCertificate: $clientCertificate, privateKey: $privateKey, pubTopic: $pubTopic, subTopic: $subTopic)';
  }
}
