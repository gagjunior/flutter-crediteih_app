import 'package:crediteih_app/services/config_service.dart';

final Map getConfigs = ConfigService.getConfigs();

class Customer {
  static final String clientId = getConfigs['clientId'];

  late final String cnpjCpf;
  late final String nome;
  late final String tipo;

  String? email;
  Map<String, dynamic>? endereco;
  Map<String, dynamic>? pesquisado;
  Map<String, dynamic>? phones;
  List<Map<String, dynamic>>? contatos;

  Customer(
      {required this.cnpjCpf,
      required this.nome,
      required this.tipo,
      this.email,
      this.contatos,
      this.endereco,
      this.phones,
      this.pesquisado});
}
