import 'package:fluent_ui/fluent_ui.dart';

import 'package:crediteih_app/pages/customers/customer_cad.dart';
import 'package:crediteih_app/pages/home_page.dart';
import 'package:crediteih_app/pages/users/user_cad.dart';

import 'package:crediteih_app/pages/shared_widgets.dart';

const Widget separator = SizedBox(height: 10);

class RecordsMenuPage extends StatelessWidget {
  const RecordsMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.all(6),
      header: PageHeader(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              FluentIcons.back,
              size: 20,
              color: Color.fromARGB(255, 10, 34, 255),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  FluentPageRoute(
                      builder: (context) => const HomePage(
                            title: 'Creditei App',
                          )));
            },
          ),
        ),
        title: titlePageHeader(FluentIcons.add_multiple, 'Cadastros',
            'Lista de cadastros disponiveis no sistema'),
      ),
      children: [
        buttonMenuPage('Usuários', 'Gerencie ou cadastre usuários',
            const UserCadPage(), context, FluentIcons.group),
        separator,
        buttonMenuPage('Clientes', 'Gerencie ou cadastre clientes',
            const CustomerCadPage(), context, FluentIcons.manager_self_service),
      ],
    );
  }
}
