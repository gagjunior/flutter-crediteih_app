import 'package:fluent_ui/fluent_ui.dart';

class ImportarArquivosPage extends StatefulWidget {
  const ImportarArquivosPage({Key? key}) : super(key: key);

  @override
  State<ImportarArquivosPage> createState() => _ImportarArquivosPageState();
}

class _ImportarArquivosPageState extends State<ImportarArquivosPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(4),
      header: const Text('Importar Arquivos'),
      content: Container(
        color: Colors.blue,
      ),
    );
  }
}
