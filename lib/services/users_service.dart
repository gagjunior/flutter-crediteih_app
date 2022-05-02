import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/exceptions/login_exception.dart';

final AwsClientCredentials credentials = AwsClientCredentials(
    accessKey: 'AKIAVIYQ2KF7CZC4DNPX',
    secretKey: '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');

final service = DynamoDB(region: 'sa-east-1', credentials: credentials);

class UserService {
  static Future<bool> isAuthenticated(String email, String password) async {
    if (email == '' || email == null) {
      throw LoginUserException('Usuário não pode estar em branco');
    }
    GetItemOutput response = await service
        .getItem(key: {'email': AttributeValue(s: email)}, tableName: 'users');
    String? user = response.item?['email']?.s.toString();
    String? userPassword = response.item?['password']?.s.toString();

    if (user == null || user == '') {
      throw LoginUserException('Erro no usuário');
    }

    if (password != userPassword) {
      throw LoginPasswordException('Erro na senha');
    }
    return true;
  }
}
