import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/exceptions/login_exception.dart';

const String usersTableName = 'Crediteih_Users';

/*final AwsClientCredentials credentials = AwsClientCredentials(
    accessKey: 'AKIAVIYQ2KF7CZC4DNPX',
    secretKey: '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');*/

//final service = DynamoDB(region: 'sa-east-1', credentials: credentials);

class UserService {
  late final String accessKey;
  late final String secretkey;
  late final String region;
  late final String clientId;
  late final AwsClientCredentials credentials;
  late final DynamoDB service;

  UserService({
    required String accessKey,
    required String secretkey,
    required String region,
    required String clientId,
  }) {
    credentials =
        AwsClientCredentials(accessKey: accessKey, secretKey: secretkey);
    service = DynamoDB(region: region, credentials: credentials);
  }

  Future<bool> isAuthenticated(
      String email, String password, String codCli) async {
    if (email == '') {
      throw LoginUserException('Usuário não pode estar em branco');
    }
    if (password == '') {
      throw LoginPasswordException('Senha não pode estar em branco');
    }
    GetItemOutput response = await service.getItem(key: {
      'email': AttributeValue(s: email),
      'clientId': AttributeValue(s: codCli)
    }, tableName: usersTableName);
    String? user = response.item?['email']?.s.toString();
    String? userPassword = response.item?['password']?.s.toString();

    if (user == null || user == '') {
      throw LoginUserException(
          'Usuário não encontrado\nVerifique com o administrador do sistema');
    }

    if (password != userPassword) {
      throw LoginPasswordException('Senha inválida');
    }
    return true;
  }
}
