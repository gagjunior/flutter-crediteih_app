import 'package:crediteih_app/pages/menus/records_page.dart';
import 'package:crediteih_app/pages/menus/reports_page.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/services/users_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class InicialPage extends StatefulWidget {
  const InicialPage({Key? key}) : super(key: key);

  @override
  State<InicialPage> createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  Map<String, dynamic> loggedUser = UserService.getLoggedUser();
  String name = '';
  String email = '';
  String loggedIn = '';

  @override
  void initState() {
    super.initState();
    name = loggedUser['name'].toString();
    email = loggedUser['email'].toString();
    loggedIn = loggedUser['loggedIn'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: titlePageHeader(
            FluentIcons.home_solid, 'Menu Inicial', 'Crediteih App'),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Bem vindo $name!',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Email: $email - $loggedIn'),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              cardInitialPage(() {
                Navigator.push(context,
                    FluentPageRoute(builder: (_) => const RecordsMenuPage()));
              }, [
                titleCardInitialPage('Cadastros', FluentIcons.add_multiple),
                const SizedBox(height: 20),
                rowCardInitialPage('- Gerencie todos cadastros do aplicativo'),
                rowCardInitialPage('- Cadastro de usuários'),
                rowCardInitialPage('- Cadastro de clientes'),
                rowCardInitialPage('... e muito mais!'),
                const SizedBox(height: 20),
                rowCardInitialPage('Clique e acesse o menu de cadastros')
              ], 100, 100),
              cardInitialPage(() {
                Navigator.push(context,
                    FluentPageRoute(builder: (_) => const ReportsMenuPage()));
              }, [
                titleCardInitialPage('Relatórios', FluentIcons.report_document),
                const SizedBox(height: 20),
                rowCardInitialPage(
                    '- Acesse todos os relatórios do aplicativo'),
                rowCardInitialPage('... e muito mais!'),
                const SizedBox(height: 20),
                rowCardInitialPage('Clique e acesse o menu de relatórios')
              ], 200, 200),
              cardInitialPage(() {}, [], 300, 300)
            ],
          ),
        ),
      ],
    );
  }
}
