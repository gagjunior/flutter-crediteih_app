import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({Key? key}) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjCpfController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _municipioController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();

  final Box customerBox = Hive.box('customer');
  static const SizedBox separator = SizedBox(height: 10);

  @override
  void initState() {
    super.initState();
    _nameController.text = customerBox.get('customer')['name'] ?? '';
    _cnpjCpfController.text = customerBox.get('customer')['cnpj_cpf'] ?? '';
    _tipoController.text = customerBox.get('customer')['tipoCadastro'] == 'J'
        ? 'Juridica'
        : 'Fisica';
    _logradouroController.text =
        customerBox.get('customer')['endereco']['logradouro'] ?? '';
    _numeroController.text =
        customerBox.get('customer')['endereco']['numero'] ?? '';
    _bairroController.text =
        customerBox.get('customer')['endereco']['bairro'] ?? '';
    _municipioController.text =
        customerBox.get('customer')['endereco']['municipio'] ?? '';
    _ufController.text = customerBox.get('customer')['endereco']['uf'] ?? '';
    _cepController.text = customerBox.get('customer')['endereco']['cep'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: Column(
        children: [
          // Cabeçalho
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
            title: titlePageHeader(null, _nameController.text,
                'CNPJ/CPF: ${_cnpjCpfController.text}'),
          ),
          //Comand bar
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            color: const Color.fromARGB(30, 0, 0, 0),
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.wrap,
              compactBreakpointWidth: 600,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Editar',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: Icon(
                      FluentIcons.edit,
                      color: Colors.green.darker,
                    ),
                    label: Text(
                      'Editar',
                      style: TextStyle(
                        color: Colors.green.normal,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Excluir',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: Icon(
                      FluentIcons.delete,
                      color: Colors.red.darker,
                    ),
                    label: Text(
                      'Excluir',
                      style: TextStyle(
                        color: Colors.red.normal,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const CommandBarSeparator(),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Lista de contatos',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.contact_list),
                    label: const Text('Gerenciar contatos'),
                    onPressed: () {},
                  ),
                ),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Gerenciar visitas',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.check_list),
                    label: const Text('Gerenciar visitas'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      children: [
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dados Gerais',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.dark,
                )),
            const Divider(size: 600),
            formTextBox(
              autofocus: true,
              controller: _nameController,
              header: 'Nome',
              readOnly: true,
            ),
            separator,
            formTextBox(
              header: 'Tipo',
              controller: _tipoController,
              readOnly: true,
            ),
            separator,
            formTextBox(
              header: customerBox.get('customer')['tipoCadastro'] == 'J'
                  ? 'CNPJ'
                  : 'CPF',
              controller: _cnpjCpfController,
              readOnly: true,
            ),
            separator,
            const SizedBox(height: 20),
            Text('Endereço',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.dark,
                )),
            const Divider(size: 600),
            formTextBox(
              header: 'Logradouro',
              largura: 600,
              keyboardType: TextInputType.streetAddress,
              controller: _logradouroController,
              readOnly: true,
            ),
            separator,
            Row(
              children: [
                formTextBox(
                  header: 'Numero',
                  largura: 90,
                  keyboardType: TextInputType.number,
                  controller: _numeroController,
                  readOnly: true,
                ),
                const SizedBox(width: 10),
                formTextBox(
                  header: 'Bairro',
                  largura: 300,
                  controller: _bairroController,
                  readOnly: true,
                ),
                const SizedBox(width: 10),
                formTextBox(
                  header: 'CEP',
                  largura: 200,
                  controller: _cepController,
                  readOnly: true,
                ),
              ],
            ),
            separator,
            Row(
              children: [
                formTextBox(
                  header: 'Municipio',
                  largura: 500,
                  controller: _municipioController,
                  readOnly: true,
                ),
                const SizedBox(width: 10),
                formTextBox(
                  header: 'UF',
                  largura: 90,
                  controller: _ufController,
                  readOnly: true,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
