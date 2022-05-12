import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:crediteih_app/models/user_model.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/services/users_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  bool isReadOnly = false;
  bool isObscureText = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                    return 'Digite um e-mail válido           ';
                  }
                  if (!EmailValidator.validate(text)) {
                    return 'E-mail não é válido';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: TextFormBox(
                header: 'Nome',
                readOnly: isReadOnly,
                maxLength: 100,
                keyboardType: TextInputType.text,
                controller: nameController,
                textInputAction: TextInputAction.next,
                obscureText: isObscureText,
                obscuringCharacter: '◉',
                autovalidateMode: AutovalidateMode.always,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Digite um nome';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: TextFormBox(
                header: 'CPF',
                readOnly: isReadOnly,
                controller: cpfController,
                maxLength: 15,
                placeholder: 'digite apenas os numeros do seu CPF',
                textInputAction: TextInputAction.next,
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
            const SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: TextFormBox(
                header: 'Senha',
                readOnly: isReadOnly,
                maxLength: 12,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                textInputAction: TextInputAction.next,
                obscureText: isObscureText,
                obscuringCharacter: '◉',
                autovalidateMode: AutovalidateMode.always,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Digite uma senha';
                  }
                  return null;
                },
                suffix: IconButton(
                  icon: Icon(
                    isObscureText ? FluentIcons.lock : FluentIcons.unlock,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 600,
              child: TextFormBox(
                header: 'Confirme a Senha',
                readOnly: isReadOnly,
                maxLength: 12,
                keyboardType: TextInputType.visiblePassword,
                controller: confirmPasswordController,
                textInputAction: TextInputAction.next,
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
                      onPressed: () async {
                        User newUser = User(
                          email: emailController.text,
                          name: nameController.text,
                          password: passwordController.text,
                          cpf: cpfController.text,
                        );
                        try {
                          await UserService.saveNewUser(newUser);
                        } on Exception catch (e) {
                          _showErrorDialog('Erro ao Salvar', e.toString());
                        }
                      },
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

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(title),
        content: Text(content),
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
