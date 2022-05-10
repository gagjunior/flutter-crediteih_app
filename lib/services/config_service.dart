import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/exceptions/config_exception.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigService {
  static final Box boxSettings = Hive.box('settings');
  static String? _accessKey;
  static String? _secretkey;
  static String? _clientId;
  static String? _region;

  static late final AwsClientCredentials _credentials;
  static late final DynamoDB _service;

  static DynamoDB startService() {
    _accessKey = boxSettings.get('accessKey');
    _secretkey = boxSettings.get('secretkey');
    _clientId = boxSettings.get('clientId');
    _region = boxSettings.get('region');

    if (_accessKey == null) {
      throw ConfigException('Chave de acesso não pode estar em branco');
    }
    if (_secretkey == null) {
      throw ConfigException('Chave de secreta não pode estar em branco');
    }
    if (_clientId == null) {
      throw ConfigException('Código do cliente não pode estar em branco');
    }
    if (_region == null) {
      throw ConfigException('Código do cliente não pode estar em branco');
    }
    _credentials =
        AwsClientCredentials(accessKey: _accessKey!, secretKey: _secretkey!);
    _service = DynamoDB(region: _region!, credentials: _credentials);

    return _service;
  }

  static void saveSettings(
      String clientId, String accessKey, String secretKey, String region) {
    boxSettings.putAll({
      'clientId': clientId,
      'accessKey': accessKey,
      'secretkey': secretKey,
      'region': region
    });
  }

  static Map<String, String> getConfigs() {
    return {
      'clientId': boxSettings.get('clientId'),
      'accessKey': boxSettings.get('accessKey'),
      'secretkey': boxSettings.get('secretkey'),
      'region': boxSettings.get('region'),
    };
  }
}
