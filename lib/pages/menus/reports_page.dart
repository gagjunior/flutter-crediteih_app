import 'package:crediteih_app/pages/customers/customer_cad.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/pages/users/user_cad.dart';
import 'package:fluent_ui/fluent_ui.dart';

const Widget separator = SizedBox(height: 10);

class ReportsMenuPage extends StatefulWidget {
  const ReportsMenuPage({Key? key}) : super(key: key);

  @override
  State<ReportsMenuPage> createState() => _ReportsMenuPageState();
}

class _ReportsMenuPageState extends State<ReportsMenuPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.all(6),
      header: PageHeader(
        title: titlePageHeader(FluentIcons.report_document, 'Relatórios',
            'Lista de relatórios disponiveis no sistema'),
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
