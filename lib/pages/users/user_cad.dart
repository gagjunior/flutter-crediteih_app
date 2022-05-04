import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

import 'package:crediteih_app/pages/users/user_new.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';

import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';
import 'package:brasil_fields/brasil_fields.dart';

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
                  label: const Text('Novo'),
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
                  onPressed: () {
                    /* String email = emailController.text;
                    selectedUser =
                        allUsers.query("email == '$email'").elementAt(0);
                    setState(() {
                      isReadOnly = false;
                    }); */
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
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
            SizedBox(
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
            SizedBox(
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
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: FilledButton(
                      child: const Text('Salvar'),
                      onPressed: isReadOnly
                          ? null
                          : () {
                              //salvar(selectedUser);
                            },
                      style: const ButtonStyle(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      child: const Text('Cancelar'),
                      onPressed: null, //isReadOnly ? null : cancelar,
                      style: ButtonStyle(
                        backgroundColor: ButtonState.resolveWith((states) {
                          if (states.isNone) {
                            return const Color.fromARGB(255, 226, 33, 33);
                          } else {
                            return const Color.fromARGB(255, 165, 22, 22);
                          }
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  /* void salvar(User user) {
    String nome = nomeController.text;
    if (nome.isEmpty) {
      _showDialogErro(
          'Nome Usuário', 'Nome do usuário não pode ficar em branco');
      return;
    }
    realm.write(() {
      user.name = nomeController.text;
      user.cpf = cpfController.text;
    });
    setState(() {
      isReadOnly = true;
    });
  }

  void cancelar() {
    setState(() {
      emailController.text = selectedUser.email;
      nomeController.text = selectedUser.name;
      if (selectedUser.cpf == null) {
        cpfController.text = '';
      } else {
        cpfController.text = selectedUser.cpf.toString();
      }
      isReadOnly = true;
    });
  } */

}
