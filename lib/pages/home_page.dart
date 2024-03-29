//Imports
import 'package:crediteih_app/pages/menus/reports_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

//Imports crediteih_app
import 'package:crediteih_app/pages/inicial_page.dart';
import 'menus/records_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        header: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Crediteih',
            softWrap: true,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue.darker,
            ),
          ),
        ),
        displayMode: PaneDisplayMode.auto,
        selected: _currentPage,
        onChanged: (i) => setState(() {
          _currentPage = i;
        }),
        items: <NavigationPaneItem>[
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Inicio'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.add_multiple),
            title: const Text('Cadastros'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.report_document),
            title: const Text('Relatórios'),
          ),
        ],
      ),
      content: NavigationBody(
        transitionBuilder: ((child, animation) =>
            DrillInPageTransition(animation: animation, child: child)),
        index: _currentPage,
        children: const <Widget>[
          InicialPage(),
          RecordsMenuPage(),
          ReportsMenuPage(),
        ],
      ),
    );
  }
}
