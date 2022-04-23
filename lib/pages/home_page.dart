//Imports
import 'package:fluent_ui/fluent_ui.dart';

//Imports crediteih_app
import 'package:crediteih_app/pages/inicial_page.dart';
import 'package:crediteih_app/pages/ncm_cad.dart';
import 'package:crediteih_app/pages/users/user_cad.dart';

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
            'Crediteih',
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
            title: const Text('Inicio'),
          ),
          PaneItemSeparator(
            thickness: 2.0,
            color: const Color.fromARGB(255, 0, 100, 255),
          ),
          PaneItemHeader(
            header: Row(
              children: const [
                Icon(FluentIcons.add_multiple),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Cadastros'),
                ),
              ],
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.add_group),
            title: const Text('Cadastro de Usuários'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.list),
            title: const Text('Cadastros de NCM'),
          ),
          PaneItemSeparator(
            thickness: 2.0,
            color: const Color.fromARGB(255, 0, 100, 255),
          ),
        ],
      ),
      content: NavigationBody(
        transitionBuilder: ((child, animation) =>
            DrillInPageTransition(child: child, animation: animation)),
        index: _currentPage,
        children: const <Widget>[
          InicialPage(),
          UserCadPage(),
          NcmCadPage(),
        ],
      ),
    );
  }
}
