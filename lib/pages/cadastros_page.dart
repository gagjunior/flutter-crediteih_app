import 'package:fluent_ui/fluent_ui.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({Key? key}) : super(key: key);

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text(
          'Cadastros',
          style: TextStyle(
            color: Color.fromARGB(255, 42, 93, 245),
            fontSize: 18,
          ),
        ),
      ),
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Card(
                padding: EdgeInsets.all(12),
                child: Text('Cadastro de Usuários'),
                elevation: 4,
              ),
            ),
            Card(child: Text('Cadastro de NCM')),
          ],
        )
      ],
    );
  }
}
