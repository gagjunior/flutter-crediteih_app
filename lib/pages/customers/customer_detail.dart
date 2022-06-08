import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({Key? key}) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  final TextEditingController _cnpjCpfController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  String name = '';
  final Box customerBox = Hive.box('customer');

  @override
  void initState() {
    super.initState();
    name = customerBox.get('customer')['name'];
    _cnpjCpfController.text = customerBox.get('customer')['cnpj_cpf'] ?? '';
    _tipoController.text = customerBox.get('customer')['tipoCadastro'] == 'J'
        ? 'Juridica'
        : 'Fisica';
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
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
        title:
            titlePageHeader(null, name, 'CNPJ/CPF: ${_cnpjCpfController.text}'),
      ),
      children: [
        Row(
          children: [
            FilledButton(child: const Text('Contatos'), onPressed: () {}),
            const SizedBox(width: 20),
            Button(child: const Text('Visitas'), onPressed: () {}),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 600,
              child: TextBox(
                header: 'CNPJ / CPF',
                readOnly: true,
                controller: _cnpjCpfController,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: TextBox(
                header: 'Tipo Cadastro (Pessoa)',
                readOnly: true,
                controller: _tipoController,
              ),
            ),
            SizedBox(height: 10),
            Text('Endereço'),
            SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: TextBox(
                header: 'Rua / Avenida / Estrada',
                readOnly: true,
              ),
            )
          ],
        )
      ],
    );
  }
}
