import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/pages/customers/customer_detail.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/services/database_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerCadPage extends StatefulWidget {
  const CustomerCadPage({Key? key}) : super(key: key);

  @override
  State<CustomerCadPage> createState() => _CustomerCadPageState();
}

class _CustomerCadPageState extends State<CustomerCadPage> {
  static const String customerTableName = 'Crediteih_Customers';
  static const SizedBox spacer = SizedBox(height: 10);
  static final Box _customerBox = Hive.box('customer');
  Map<int, Map<String, AttributeValue>>? allCustomers;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: Column(
        children: [
          PageHeader(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: IconButton(
                icon: const Icon(
                  FluentIcons.back,
                  size: 20,
                  color: Color.fromARGB(255, 10, 34, 255),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Row(
              children: [
                titlePageHeader(FluentIcons.add_group, 'Cadastro de Clientes',
                    'Cadastre e gerencie os clientes'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            color: const Color.fromARGB(30, 0, 0, 0),
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.wrap,
              compactBreakpointWidth: 600,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Listar todos os clientes',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.list),
                    label: const Text(
                      'Listar todos',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      _showProgress(context, 'Carregando', 'Buscando clientes');
                      await DataBaseService.getAll(
                              tableName: customerTableName, orderBy: 'name')
                          .then((value) {
                        Navigator.of(context).pop();
                        setState(() {
                          allCustomers = value;
                        });
                      });
                    },
                  ),
                ),
                const CommandBarSeparator(),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Cadastrar novo cliente',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text('Adicionar'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          spacer,
        ],
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: allCustomers?.length ?? 0,
          itemBuilder: (context, index) {
            final title = allCustomers?[index]?['name']?.s;
            final subtitle = allCustomers?[index]?['email']?.s;
            return Container(
              margin: const EdgeInsets.all(4),
              child: TappableListTile(
                tileColor: ButtonState.resolveWith((states) {
                  if (states.isNone) {
                    return Colors.grey[30];
                  }
                  return Colors.grey[50];
                }),
                trailing: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(FluentIcons.chrome_back_mirrored),
                ),
                isThreeLine: true,
                leading: Row(
                  children: [
                    Chip(
                      image: Icon(
                        FluentIcons.edit,
                        size: 14,
                        color: Colors.green,
                      ),
                      text: Text(
                        'Editar',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 4),
                    Chip(
                      image: Icon(
                        FluentIcons.delete,
                        size: 14,
                        color: Colors.red,
                      ),
                      text: Text(
                        'Excluir',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                title: Text(title ?? ''),
                subtitle: Text(subtitle ?? ''),
                onTap: (() {
                  _customerBox.putAll(
                    {
                      'customer': {
                        'name': allCustomers?[index]?['name']?.s,
                        'cnpj_cpf': allCustomers?[index]?['cnpj_cpf']?.s,
                        'tipoCadastro':
                            allCustomers?[index]?['tipoCadastro']?.s,
                        'endereco': {
                          'bairro': allCustomers?[index]?['endereco']
                              ?.m?['bairro']
                              ?.s,
                          'cep':
                              allCustomers?[index]?['endereco']?.m?['cep']?.s,
                          'complemento': allCustomers?[index]?['endereco']
                              ?.m?['complemento']
                              ?.s,
                          'logradouro': allCustomers?[index]?['endereco']
                              ?.m?['logradouro']
                              ?.s,
                          'municipio': allCustomers?[index]?['endereco']
                              ?.m?['municipio']
                              ?.s,
                          'numero': allCustomers?[index]?['endereco']
                              ?.m?['numero']
                              ?.n,
                          'uf': allCustomers?[index]?['endereco']?.m?['uf']?.s,
                          //'pontosReferencia': allCustomers?[index]?['endereco']?.m?['pontosReferencia']?.l
                        },
                      }
                    },
                  );
                  Navigator.push(
                    context,
                    FluentPageRoute(
                      builder: (context) => const CustomerDetail(),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showProgress(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(title),
        content: SizedBox(
          height: 100,
          width: 150,
          child: Column(
            children: [
              const ProgressRing(),
              Text(msg),
            ],
          ),
        ),
      ),
    );
  }
}
