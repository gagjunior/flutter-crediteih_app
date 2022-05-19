import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:crediteih_app/services/users_service.dart';
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
  Map<int, Map<String, AttributeValue>>? allUsers;

  @override
  void initState() {
    super.initState();
    UserService.getAllUsers().then((value) {
      setState(() {
        allUsers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: const EdgeInsets.all(6),
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
            title: titlePageHeader(
                FluentIcons.add_group,
                'Cadastro de Usuários',
                'Cadastre e gerencie os usuários do sistema'),
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
              ],
            ),
          ),
          spacer,
          spacer
        ],
      ),
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: allUsers?.length,
        itemBuilder: (context, index) {
          final title = allUsers?[index]?['name']?.s;
          final subtitle = allUsers?[index]?['email']?.s;
          return TappableListTile(
            onTap: (() {
              showDialog(
                  context: context,
                  builder: (_) => ContentDialog(
                        title: Text('Usuario: ${title ?? ''}'),
                        content: const Text('Teste'),
                        actions: [
                          FilledButton(
                              child: const Text('Voltar'),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      ));
            }),
            leading: const CircleAvatar(),
            title: Text(title ?? ''),
            subtitle: Text(subtitle ?? ''),
          );
        },
      ),
    );
  }

  void _showProgress(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(title),
        content: SizedBox(
          height: 100,
          width: 150,
          child: Column(
            children: [
              const ProgressRing(),
              Text(msg),
            ],
          ),
        ),
      ),
    );
  }
}
