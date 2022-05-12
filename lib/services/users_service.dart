import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/exceptions/login_exception.dart';
import 'package:crediteih_app/models/user_model.dart';
import 'package:crediteih_app/services/config_service.dart';

const String usersTableName = 'Crediteih_Users';

class UserService {
  static final DynamoDB service = ConfigService.startService();
  static final Map getConfigs = ConfigService.getConfigs();

  static Future<void> saveNewUser(User user) async {
    String value = """
      INSERT INTO $usersTableName VALUE
      {
        'email': '${user.email}',
        'clientId': '${getConfigs['clientId']}',
        'address': {
          'cep': '',
          'cidade': 'Curitiba',
          'complemento': '',
          'logradouro': '',
          'numero': 0,
          'referencias': [
          'Escola',
          'Mercado'
          ],
          'uf': 'PR'
        },
        'cpf': '${user.cpf}',
        'name': '${user.name}',
        'password': '${user.password}'
      }
    """;
    await service
        .executeStatement(statement: value)
        .onError<DuplicateItemException>((error, stackTrace) {
      if (error.code == 'DuplicateItemException') {
        throw Exception('Já existe usuário criado com o e-mail informado');
      } else {
        throw Exception();
      }
    });
  }

  // Metodo que faz a autenticação do usuário
  static Future<bool> isAuthenticated(String email, String password) async {
    if (email == '') {
      throw LoginUserException('Usuário não pode estar em branco');
    }
    if (password == '') {
      throw LoginPasswordException('Senha não pode estar em branco');
    }
    GetItemOutput response = await service.getItem(key: {
      'email': AttributeValue(s: email),
      'clientId': AttributeValue(s: getConfigs['clientId'])
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
