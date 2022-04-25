import 'package:brasil_fields/brasil_fields.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:realm/realm.dart';

import '../../models/user_model.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  late Realm realm;
  bool isReadOnly = false;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();

  _NewUserPageState() {
    final Configuration config = Configuration([User.schema]);
    realm = Realm(config);
  }

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
        title: titlePageHeader(FluentIcons.user_followed, 'Novo Usuário',
            'Cadastre um novo usuário'),
      ),
      children: [
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
                      onPressed: () {},
                      style: const ButtonStyle(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      child: const Text('Cancelar'),
                      onPressed: () {},
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
}
