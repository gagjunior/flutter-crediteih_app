//Imports
import 'package:fluent_ui/fluent_ui.dart';

//Imports crediteih_app
import 'package:crediteih_app/pages/inicial_page.dart';
import 'package:crediteih_app/pages/importar_arquivos_page.dart';
import 'package:crediteih_app/pages/cadastros_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
        selected: _currentPage,
        onChanged: (i) => setState(() {
          _currentPage = i;
        }),
        header: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Crediteih App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 19, 52, 216),
              fontSize: 16,
            ),
          ),
        ),
        items: <NavigationPaneItem>[
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.open_file),
            title: const Text('Importar Arquivos'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.add_multiple),
            title: const Text('Cadastros'),
          ),
        ],
      ),
      content: NavigationBody(
        transitionBuilder: ((child, animation) =>
            DrillInPageTransition(child: child, animation: animation)),
        index: _currentPage,
        children: const <Widget>[
          InicialPage(),
          ImportarArquivosPage(),
          CadastrosPage()
        ],
      ),
    );
  }
}
