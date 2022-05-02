import 'package:crediteih_app/pages/customers/customer_cad.dart';
import 'package:crediteih_app/pages/home_page.dart';
import 'package:crediteih_app/pages/users/user_cad.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../shared_widgets.dart';

const Widget separator = SizedBox(height: 10);

class RecordsMenuPage extends StatelessWidget {
  const RecordsMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.all(6),
      header: PageHeader(
        title: titlePageHeader(FluentIcons.add_multiple, 'Cadastros',
            'Lista de cadastros disponiveis no sistema'),
      ),
      children: [
        buttonMenuPage('Usuários', 'Gerencie ou cadastre usuários',
            UserCadPage(), context, FluentIcons.group),
        separator,
        buttonMenuPage('Clientes', 'Gerencie ou cadastre clientes',
            CustomerCadPage(), context, FluentIcons.manager_self_service),
      ],
    );
  }
}
