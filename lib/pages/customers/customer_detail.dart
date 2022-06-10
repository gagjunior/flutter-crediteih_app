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
            SizedBox(
              width: 600,
              child: TextBox(
                header: 'Nome',
                readOnly: true,
                controller: _nameController,
                autofocus: true,
                keyboardType: TextInputType.text,
                showCursor: true,
                textInputAction: TextInputAction.next,
              ),
            ),
            separator,
            SizedBox(
              width: 600,
              child: TextBox(
                header: 'CNPJ / CPF',
                readOnly: true,
                controller: _cnpjCpfController,
                keyboardType: TextInputType.text,
                showCursor: true,
                textInputAction: TextInputAction.next,
              ),
            ),
            separator,
            SizedBox(
              width: 600,
              child: TextBox(
                header: 'Tipo Cadastro (Pessoa)',
                readOnly: true,
                controller: _tipoController,
                keyboardType: TextInputType.text,
                showCursor: true,
              ),
            ),
            separator,
            const Text('Endereço'),
            separator,
            Row(
              children: [
                SizedBox(
                  width: 500,
                  child: TextBox(
                    header: 'Rua / Avenida / Rodovia',
                    readOnly: true,
                    controller: _logradouroController,
                    keyboardType: TextInputType.streetAddress,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 90,
                  child: TextBox(
                    header: 'Numero',
                    readOnly: true,
                    controller: _numeroController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            separator,
            Row(
              children: [
                SizedBox(
                  width: 290,
                  child: TextBox(
                    header: 'CEP',
                    readOnly: true,
                    controller: _cepController,
                    showCursor: true,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: TextBox(
                    header: 'Bairro',
                    readOnly: true,
                    controller: _bairroController,
                  ),
                ),
              ],
            ),
            separator,
            Row(
              children: [
                SizedBox(
                  width: 500,
                  child: TextBox(
                    header: 'Municipio',
                    readOnly: true,
                    controller: _municipioController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 90,
                  child: TextBox(
                    header: 'UF',
                    readOnly: true,
                    controller: _ufController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
