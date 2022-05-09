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

  String? get accessKey => _accessKey;
  String? get secretkey => _secretkey;
  String? get clientId => _clientId;
  String? get region => _region;

  static late final AwsClientCredentials credentials;
  static late final DynamoDB service;

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

  static DynamoDB startService() {
    _accessKey = boxSettings.get('accessKey');
    _secretkey = boxSettings.get('secretkey');
    _clientId = boxSettings.get('clientId');
    _region = boxSettings.get('region');

    credentials =
        AwsClientCredentials(accessKey: _accessKey!, secretKey: _secretkey!);
    service = DynamoDB(region: _region!, credentials: credentials);

    return service;
  }

  static void saveSettings(
      String codCli, String accessKey, String secretKey, String region) {
    boxSettings.putAll({
      'clientId': codCli,
      'accessKey': accessKey,
      'secretkey': secretKey,
      'region': region
    });
  }
}
