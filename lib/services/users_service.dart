// Imports de bibliotecas externas
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:intl/intl.dart';

// Imports de bibliotecas internas
import 'package:crediteih_app/exceptions/login_exception.dart';
import 'package:crediteih_app/exceptions/user_exception.dart';
import 'package:crediteih_app/models/user_model.dart';
import 'package:crediteih_app/services/config_service.dart';

const String usersTableName = 'Crediteih_Users';

class UserService {
  static final DynamoDB service = ConfigService.startService();
  static final Map getConfigs = ConfigService.getConfigs();
  static final Box _boxLoggedUser = Hive.box('loggedUser');

  static void _validateFields(User user) {
    if (user.email == '') {
      throw EmailUserException('Email não pode ficar em branco');
    }
    if (user.name == '') {
      throw NameUserException('Nome não pode ficar em branco');
    }
    if (user.password == '') {
      throw PasswordUserException('Senha não pode ficar em branco');
    }
  }

  static Future<void> saveNewUser(User user) async {
    _validateFields(user);
    String statement = """
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
        .executeStatement(statement: statement)
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
    User user = User(
        email: response.item?['email']?.s.toString(),
        name: response.item?['name']?.s.toString(),
        password: response.item?['password']?.s.toString());

    if (user.email == null || user.email == '') {
      throw LoginUserException(
          'Usuário não encontrado\nVerifique com o administrador do sistema');
    }

    if (password != user.password) {
      throw LoginPasswordException('Senha inválida');
    }

    _saveLoggedUser(user);

    return true;
  }

  static Future<Map<int, Map<String, AttributeValue>>?> getAllUsers() async {
    const String statement = 'SELECT * FROM $usersTableName';
    final response = await service.executeStatement(statement: statement);
    Map<int, Map<String, AttributeValue>>? users = response.items?.asMap();
    return users;
  }

  static void _saveLoggedUser(User user) async {
    DateTime dateTime = DateTime.now();
    await _boxLoggedUser.putAll({
      'loggedUser': {
        'email': user.email,
        'name': user.name,
        'password': user.password,
        'loggedIn': DateFormat("'Login em:' dd/MM/yyyy hh:mm").format(dateTime)
      }
    });
  }
}
