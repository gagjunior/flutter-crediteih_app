import 'package:fluent_ui/fluent_ui.dart';

import 'package:crediteih_app/pages/users/user_new.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';

const Widget spacer = SizedBox(height: 10.0);

class UserCadPage extends StatefulWidget {
  const UserCadPage({Key? key}) : super(key: key);

  @override
  State<UserCadPage> createState() => _UserCadPageState();
}

class _UserCadPageState extends State<UserCadPage> {
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
              Navigator.pop(context);
            },
          ),
        ),
        title: titlePageHeader(FluentIcons.add_group, 'Cadastro de Usuários',
            'Cadastre e gerencie os usuários do sistema'),
      ),
      children: [
        Container(
          color: const Color.fromARGB(30, 0, 0, 0),
          child: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.wrap,
            compactBreakpointWidth: 600,
            primaryItems: [
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: 'Inserir novo usuário',
                  child: w,
                ),
                wrappedItem: CommandBarButton(
                  icon: const Icon(FluentIcons.add),
                  label: const Text('Adicionar'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (context) => const NewUserPage(),
                        ));
                  },
                ),
              ),
              const CommandBarSeparator(),
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: "Editar o usuário selecionado",
                  child: w,
                ),
                wrappedItem: CommandBarButton(
                  icon: const Icon(FluentIcons.edit),
                  label: const Text('Editar'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        spacer,
        // Separador
      ],
    );
  }
}
