import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/exceptions/config_exception.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigService {
  final Box boxSettings = Hive.box('settings');
  String? _accessKey;
  String? _secretkey;
  String? _clientId;
  String? _region;

  String? get accessKey => _accessKey;
  String? get secretkey => _secretkey;
  String? get clientId => _clientId;
  String? get region => _region;

  late final AwsClientCredentials credentials;
  late final DynamoDB service;

  set accessKey(String? accessKey) {
    if (accessKey == null) {
      throw ConfigException('Chave de acesso não pode estar em branco');
    } else {
      _accessKey = accessKey;
    }
  }

  set secretkey(String? secretkey) {
    if (secretkey == null) {
      throw ConfigException('Chave secreta não pode estar em branco');
    } else {
      _secretkey = secretkey;
    }
  }

  set clientId(String? clientId) {
    if (clientId == null) {
      throw ConfigException('Código do cliente não pode estar em branco');
    } else {
      _clientId = clientId;
    }
  }

  set region(String? region) {
    if (region == null) {
      throw ConfigException('Região não pode estar em branco');
    } else {
      _region = region;
    }
  }

  DynamoDB startService() {
    accessKey = boxSettings.get('accessKey');
    secretkey = boxSettings.get('secretkey');
    clientId = boxSettings.get('clientId');
    region = boxSettings.get('region');

    credentials =
        AwsClientCredentials(accessKey: accessKey!, secretKey: secretkey!);
    service = DynamoDB(region: region!, credentials: credentials);

    return service;
  }

  void saveSettings(
      String codCli, String accessKey, String secretKey, String region) {
    boxSettings.putAll({
      'clientId': codCli,
      'accessKey': accessKey,
      'secretkey': secretKey,
      'region': region
    });
  }
}
