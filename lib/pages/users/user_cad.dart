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
                    message: 'Listar todos os usuários',
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
                    onPressed: () async {
                      _showProgress(context, 'Carregando', 'Buscando usuários');
                      await UserService.getAllUsers().then((value) {
                        Navigator.of(context).pop();
                        setState(() {
                          allUsers = value;
                        });
                      });
                    },
                  ),
                ),
                const CommandBarSeparator(),
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
              ],
            ),
          ),
          spacer,
          spacer
        ],
      ),
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: allUsers?.length ?? 0,
        itemBuilder: (context, index) {
          final title = allUsers?[index]?['name']?.s;
          final subtitle = allUsers?[index]?['email']?.s;
          var user = allUsers?[index];
          return TappableListTile(
            leading: DropDownButton(
              title: const Icon(
                FluentIcons.more_vertical,
                color: Colors.white,
              ),
              items: [
                MenuFlyoutItem(
                  selected: true,
                  text: const Text('Editar'),
                  leading: Icon(FluentIcons.edit, color: Colors.green.dark),
                  onPressed: () => debugPrint('Send'),
                ),
                MenuFlyoutItem(
                  text: const Text('Excluir'),
                  leading: Icon(FluentIcons.delete, color: Colors.red.dark),
                  onPressed: () => debugPrint('Reply'),
                ),
              ],
              buttonStyle: ButtonStyle(
                backgroundColor: ButtonState.resolveWith((states) {
                  if (states.isNone) {
                    return Colors.blue;
                  }
                  if (states.isHovering) {
                    return Colors.grey;
                  }
                  return null;
                }),
              ),
            ),
            title: Text(title ?? ''),
            subtitle: Text(subtitle ?? ''),
            onTap: (() {}),
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

  void _showUserDetail(BuildContext context, Map<String, AttributeValue> user) {
    var name = user['name']?.s;
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(name ?? ''),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
        actions: [
          FilledButton(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
