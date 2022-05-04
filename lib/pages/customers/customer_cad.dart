import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomerCadPage extends StatefulWidget {
  const CustomerCadPage({Key? key}) : super(key: key);

  @override
  State<CustomerCadPage> createState() => _CustomerCadPageState();
}

class _CustomerCadPageState extends State<CustomerCadPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
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
              Navigator.pop(context);
            },
          ),
        ),
        title: titlePageHeader(FluentIcons.manager_self_service,
            'Cadastro de Clientes', 'Cadastre e gerencie clientes'),
      ),
      children: const [],
    );
  }
}
