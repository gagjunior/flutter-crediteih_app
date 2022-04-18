import 'package:fluent_ui/fluent_ui.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({Key? key}) : super(key: key);

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      header: PageHeader(
        title: Text(
          'Cadastros',
          style: TextStyle(
            color: Color.fromARGB(255, 42, 93, 245),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
