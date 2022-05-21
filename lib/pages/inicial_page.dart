import 'package:crediteih_app/pages/menus/records_page.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/pages/users/user_cad.dart';
import 'package:fluent_ui/fluent_ui.dart';

class InicialPage extends StatefulWidget {
  const InicialPage({Key? key}) : super(key: key);

  @override
  State<InicialPage> createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: titlePageHeader(
            FluentIcons.home_solid, 'Menu Inicial', 'Crediteih App'),
      ),
      content: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Card(
              child: InfoLabel(
                label: 'Cadastros',
                labelStyle: TextStyle(
                  color: Colors.blue.darker,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacer,
                    const Text(
                      'Acesse todos os cadastros do aplicativo',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                    ),
                    const Text(
                      '- Cadastros de usuários',
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                    ),
                    const Text('- Cadastro de clientes'),
                    const Text('... e muito mais!'),
                    spacer,
                    SizedBox(
                      width: 300,
                      child: FilledButton(
                        child: const Text('Acessar'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            FluentPageRoute(
                                builder: (context) => const RecordsMenuPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: InfoLabel(
                label: 'Cadastros',
                labelStyle: TextStyle(
                  color: Colors.blue.darker,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Acesse todos os cadastros do aplicativo',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                    ),
                    const Text(
                      '- Cadastros de usuários',
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                    ),
                    const Text('- Cadastro de clientes'),
                    const Text('... e muito mais!'),
                    spacer,
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        child: const Text('Acessar'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: InfoLabel(
                label: 'Cadastros',
                labelStyle: TextStyle(
                  color: Colors.blue.darker,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacer,
                    const Text(
                      'Acesse todos os cadastros do aplicativo',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                    ),
                    const Text(
                      '- Cadastros de usuários',
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                    ),
                    const Text('- Cadastro de clientes'),
                    const Text('... e muito mais!'),
                    spacer,
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        child: const Text('Acessar'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
