import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomerCadPage extends StatefulWidget {
  const CustomerCadPage({Key? key}) : super(key: key);

  @override
  State<CustomerCadPage> createState() => _CustomerCadPageState();
}

class _CustomerCadPageState extends State<CustomerCadPage> {
  static const SizedBox spacer = SizedBox(height: 10);
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: Column(
        children: [
          PageHeader(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
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
            title: titlePageHeader(FluentIcons.add_group,
                'Cadastro de Clientes', 'Cadastre e gerencie os clientes'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            color: const Color.fromARGB(30, 0, 0, 0),
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.wrap,
              compactBreakpointWidth: 600,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Listar todos os clientes',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.list),
                    label: const Text(
                      'Listar todos',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {},
                  ),
                ),
                const CommandBarSeparator(),
                CommandBarBuilderItem(
                  builder: (context, mode, w) => Tooltip(
                    message: 'Cadastrar novo cliente',
                    child: w,
                  ),
                  wrappedItem: CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text('Adicionar'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          spacer,
          spacer
        ],
      ),
      children: [],
    );
  }
}
