// Imports de bibliotecas externas
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';

// Imports de bibliotecas internas
import 'package:crediteih_app/exceptions/user_exception.dart';
import 'package:crediteih_app/models/user_model.dart';
import 'package:crediteih_app/services/config_service.dart';

const String usersTableName = 'Crediteih_Users';
const String customerTableName = 'Crediteih_Customers';

class UserService {
  static final DynamoDB service = ConfigService.startService();
  static final Map getConfigs = ConfigService.getConfigs();

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

  // Salvar novo usuário na base de dados
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

  // Recupera todos clientes da base de dados
  static Future<Map<int, Map<String, AttributeValue>>?>
      getAllCustomers() async {
    const String statement = "SELECT * FROM $customerTableName";
    final response = await service.executeStatement(statement: statement);
    Map<int, Map<String, AttributeValue>>? customers = response.items?.asMap();
    return customers;
  }
}
