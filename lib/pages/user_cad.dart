import 'package:brasil_fields/brasil_fields.dart';
import 'package:crediteih_app/models/user_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

const Widget spacer = SizedBox(height: 6.0);

class UserCadPage extends StatefulWidget {
  const UserCadPage({Key? key}) : super(key: key);

  @override
  State<UserCadPage> createState() => _UserCadPageState();
}

class _UserCadPageState extends State<UserCadPage> {
  late Realm realm;

  bool isReadOnly = true;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController testeController = TextEditingController();

  _UserCadPageState() {
    final Configuration config = Configuration([User.schema]);
    realm = Realm(config);
    RealmResults<User> allUsers = realm.all<User>();

    // Verifica se existe algum usuário criado
    // Se não existir cria o usuário admin
    if (allUsers.isEmpty) {
      realm.write(() {
        User admin = User('admin@admin.com', 'admin', 'admin123456');
        realm.add(admin);
      });
    } else {
      User admin = allUsers.last;
      nomeController.text = admin.name;
      emailController.text = admin.email;
      if (admin.cpf != null && admin.cpf != '') {
        cpfController.text = admin.cpf.toString();
      } else {
        cpfController.text = '';
      }
    }
  }

  late RealmResults<User> allUsers = realm.all<User>();
  late User selectedUser = allUsers.last;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.all(6),
      header: PageHeader(
        title: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Cadastro de Usuários',
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 10, 34, 255),
                ),
              ),
              Text(
                'Cadastre e gerencie os usuários do aplicativo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FluentIcons.add_group,
            size: 26,
            color: Color.fromARGB(255, 10, 34, 255),
          ),
        ),
      ),
      children: [
        Container(
          color: Color.fromARGB(30, 0, 0, 0),
          child: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.wrap,
            compactBreakpointWidth: 600,
            primaryItems: [
              CommandBarBuilderItem(
                builder: (context, mode, w) => Tooltip(
                  message: "Editar o usuário selecionado",
                  child: w,
                ),
                wrappedItem: CommandBarButton(
                  icon: const Icon(FluentIcons.edit),
                  label: const Text('Editar'),
                  onPressed: () {
                    String email = emailController.text;
                    selectedUser =
                        allUsers.query("email == '$email'").elementAt(0);

                    setState(() {
                      isReadOnly = false;
                      testeController.text = selectedUser.email;
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
                  label: const Text('Novo'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 600,
              child: TextFormBox(
                header: 'E-mail',
                autofocus: true,
                readOnly: isReadOnly,
                maxLength: 100,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '';
                  }
                  if (!EmailValidator.validate(text)) {
                    return 'E-mail não é válido';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 600,
              child: TextFormBox(
                header: 'Nome',
                readOnly: isReadOnly,
                maxLength: 100,
                keyboardType: TextInputType.text,
                controller: nomeController,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              width: 600,
              child: TextFormBox(
                header: 'CPF',
                readOnly: isReadOnly,
                controller: cpfController,
                maxLength: 15,
                placeholder: 'digite apenas os numeros do seu CPF',
                autovalidateMode: AutovalidateMode.always,
                validator: (text) {
                  if (text.toString().isEmpty || text == null) {
                    return '';
                  }
                  if (!GetUtils.isCpf(text.toString())) {
                    return 'CPF inválido';
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
            ),
            SizedBox(height: 14),
            Container(
              width: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: FilledButton(
                      child: Text('Salvar'),
                      onPressed: isReadOnly
                          ? null
                          : () {
                              salvar(selectedUser);
                            },
                      style: ButtonStyle(),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      child: Text('Cancelar'),
                      onPressed: isReadOnly ? null : cancelar,
                      style: ButtonStyle(
                        backgroundColor: ButtonState.resolveWith((states) {
                          if (states.isNone) {
                            return Color.fromARGB(255, 226, 33, 33);
                          } else {
                            return Color.fromARGB(255, 165, 22, 22);
                          }
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 600,
              child: TextFormBox(
                header: 'Usuario selecionado',
                readOnly: isReadOnly,
                maxLength: 100,
                keyboardType: TextInputType.text,
                controller: testeController,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        )
      ],
    );
  }

  void salvar(User user) {
    realm.write(() {
      user.name = nomeController.text;
      user.cpf = cpfController.text;
    });
    realm.close();
    setState(() {
      isReadOnly = true;
    });
  }

  void cancelar() {
    setState(() {
      isReadOnly = true;
    });
  }
}
