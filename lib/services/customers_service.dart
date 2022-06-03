import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/services/config_service.dart';

class CustomerService {
  static const String customerTableName = 'Crediteih_Customers';
  static final DynamoDB service = ConfigService.startService();
  static final Map getConfigs = ConfigService.getConfigs();

  // Recupera todos clientes da base de dados
  static Future<Map<int, Map<String, AttributeValue>>?>
      getAllCustomers() async {
    const String statement = "SELECT * FROM $customerTableName";
    final response = await service.executeStatement(statement: statement);
    Map<int, Map<String, AttributeValue>>? customers = response.items?.asMap();
    return customers;
  }
}
