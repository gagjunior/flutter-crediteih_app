import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/exceptions/user_exception.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:crediteih_app/exceptions/login_exception.dart';
import 'package:crediteih_app/models/user_model.dart';
import 'package:crediteih_app/services/config_service.dart';
import 'package:intl/intl.dart';

class DataBaseService {
  static final DynamoDB service = ConfigService.startService();
  static final Map getConfigs = ConfigService.getConfigs();
  static final Box _boxLoggedUser = Hive.box('loggedUser');

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
    }, tableName: 'Crediteih_Users');
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

  // Salva localmente usuário logado no sistema
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

  // Recupera usuário logado no sistema
  static Map<String, dynamic> getLoggedUser() {
    return _boxLoggedUser.get('loggedUser');
  }

  // Recupera todos os registros de uma tabela do banco de dados
  static Future<Map<int, Map<String, AttributeValue>>?> getAll(
      {required String tableName, required String orderBy}) async {
    final String statement = 'SELECT * FROM $tableName';
    final response = await service.executeStatement(statement: statement);
    response.items?.sort(((a, b) => a[orderBy]!.s!.compareTo(b[orderBy]!.s!)));
    return response.items?.asMap();
  }

  // Exclui um registro de uma tabela do banco de dados
  static Future<void> deleteItem(
      {required Map<String, AttributeValue> keyItem,
      required String tableName}) async {
    keyItem.addAll({'clientId': AttributeValue(s: getConfigs['clientId'])});
    await service.deleteItem(key: keyItem, tableName: tableName);
  }

  static void validateFields(User user) {
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

  static Future<void> saveNewItem(
      {required Map<String, AttributeValue> newItem,
      required String tableName}) async {
    newItem.addAll({'clientId': AttributeValue(s: getConfigs['clientId'])});
    service
        .putItem(item: newItem, tableName: tableName)
        .onError<DuplicateItemException>((error, stackTrace) {
      if (error.code == 'DuplicateItemException') {
        throw Exception('Já existe usuário criado com o e-mail informado');
      } else {
        throw Exception();
      }
    });
  }
}
