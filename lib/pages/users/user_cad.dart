import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:crediteih_app/pages/users/user_new.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/services/users_service.dart';

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
    return ScaffoldPage.scrollable(
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
                        _showProgress(
                            context, 'Carregando', 'Buscando usuários');
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
                          ),
                        );
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
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: allUsers?.length ?? 0,
            itemBuilder: (context, index) {
              final title = allUsers?[index]?['name']?.s;
              final subtitle = allUsers?[index]?['email']?.s;
              var user = allUsers?[index];
              return TappableListTile(
                leading: Row(
                  children: [
                    Chip(
                      image: Icon(
                        FluentIcons.edit,
                        size: 14,
                        color: Colors.green,
                      ),
                      text: Text(
                        'Editar',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (context) => const NewUserPage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Chip(
                      image: Icon(
                        FluentIcons.delete,
                        size: 14,
                        color: Colors.red,
                      ),
                      text: Text(
                        'Excluir',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () => _showDeleteDialog(context, user),
                    )
                  ],
                ),
                title: Text(title ?? ''),
                subtitle: Text(subtitle ?? ''),
                onTap: (() {
                  _showUserDetailDialog(context, user);
                }),
              );
            },
          ),
        ]);
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

  void _showDeleteDialog(
      BuildContext context, Map<String, AttributeValue>? user) {
    final String? email = user?['email']?.s;
    final String? name = user?['name']?.s;
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(
          'Excluir?',
          style: TextStyle(
            color: Colors.red.dark,
          ),
        ),
        content: SizedBox(
          height: 250,
          child: ScaffoldPage.scrollable(
            children: [
              const Text('Tem certeza que deseja EXCLUIR o usuário?'),
              const SizedBox(height: 10),
              Text(
                name ?? '',
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              Text(
                email ?? '',
              ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () async =>
                await UserService.deleteUser(email).then((value) async {
              await UserService.getAllUsers().then((value) {
                Navigator.of(context).pop();
                setState(() {
                  allUsers = value;
                });
              });
            }),
            style: ButtonStyle(
              backgroundColor: ButtonState.resolveWith((states) {
                if (states.isNone) {
                  return Colors.red.light;
                }
                return null;
              }),
            ),
            child: const Text('Excluir'),
          ),
          FilledButton(
            autofocus: true,
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showUserDetailDialog(
      BuildContext context, Map<String, AttributeValue>? user) {
    String? name = user?['name']?.s;
    String? email = user?['email']?.s;
    String? cpf = user?['cpf']?.s;
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(name ?? ''),
        content: ScaffoldPage.scrollable(
          children: [
            InfoLabel(
              label: 'Email',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              child: SelectableText(
                email ?? '',
                selectionControls: fluentTextSelectionControls,
                showCursor: true,
              ),
            ),
            const SizedBox(height: 6),
            InfoLabel(
              label: 'CPF',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              child: SelectableText(
                cpf ?? '',
                selectionControls: fluentTextSelectionControls,
                showCursor: true,
              ),
            )
          ],
        ),
        actions: [
          FilledButton(
            child: const Text('Voltar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
