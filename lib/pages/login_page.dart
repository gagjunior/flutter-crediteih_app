//Imports de terceiros
import 'package:crediteih_app/exceptions/config_exception.dart';
import 'package:crediteih_app/services/config_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:email_validator/email_validator.dart';
//Imports do projeto
import 'package:crediteih_app/pages/home_page.dart';
import 'package:crediteih_app/exceptions/login_exception.dart';
import 'package:crediteih_app/services/users_service.dart';

//const String codCli = 'CTBA0001';

final Map getConfigs = ConfigService.getConfigs();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController accessKeyController = TextEditingController();
  final TextEditingController secretKeyController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('images/logo_app.png')),
                ),
              ),
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormBox(
                    controller: emailController,
                    header: 'Email',
                    placeholder: 'Digite seu e-mail...',
                    autovalidateMode: AutovalidateMode.always,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Digite um e-mail';
                      }
                      if (!EmailValidator.validate(text)) {
                        return 'E-mail não é válido';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textAlignVertical: TextAlignVertical.center,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        FluentIcons.mail,
                        color: Color.fromRGBO(0, 64, 255, 1.0),
                        size: 24,
                      ),
                    ),
                    cursorHeight: 26,
                    keyboardType: TextInputType.emailAddress,
                    minHeight: 40,
                    autofocus: true,
                    cursorColor: Colors.blue,
                    style: const TextStyle(
                      letterSpacing: 3,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormBox(
                    controller: passwordController,
                    header: 'Senha',
                    placeholder: 'Digite sua senha...',
                    autovalidateMode: AutovalidateMode.always,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Digite a senha';
                      }
                      if (text.length < 8 || text.length > 12) {
                        return 'A senha deve estar entre 8 e 12 caracteres';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    textAlignVertical: TextAlignVertical.center,
                    minHeight: 40,
                    cursorHeight: 26,
                    obscureText: !_showPassword,
                    obscuringCharacter: '◉',
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 12,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        FluentIcons.password_field,
                        color: Color.fromRGBO(0, 64, 255, 1.0),
                        size: 24,
                      ),
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        !_showPassword ? FluentIcons.lock : FluentIcons.unlock,
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    style: const TextStyle(
                      letterSpacing: 3,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              FilledButton(
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                onPressed: () async {
                  try {
                    _showProgress(context, 'Login', 'Conectando...');
                    await UserService.isAuthenticated(
                            emailController.text, passwordController.text)
                        .then((value) => Navigator.of(context).pop());
                    Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (context) => const HomePage(
                            title: 'Crediteih App',
                          ),
                        ));
                  } on LoginUserException catch (e) {
                    Navigator.of(context).pop();
                    _showDialogLogin('Erro de Usuário', e.toString());
                  } on LoginPasswordException catch (e) {
                    Navigator.of(context).pop();
                    _showDialogLogin('Erro de Senha', e.toString());
                  } on ConfigException catch (e) {
                    Navigator.of(context).pop();
                    _showDialogLogin('Configurações', e.toString());
                  }
                },
                style: ButtonStyle(
                  padding: ButtonState.all(const EdgeInsets.symmetric(
                      horizontal: 120, vertical: 10)),
                  backgroundColor: ButtonState.resolveWith((states) {
                    if (states.isHovering) {
                      return const Color.fromARGB(255, 7, 55, 128);
                    } else {
                      return const Color.fromARGB(255, 10, 85, 247);
                    }
                  }),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Icon(
                              FluentIcons.settings_add,
                              size: 20,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text('Configurações'),
                          ],
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          clientIdController.text =
                              getConfigs['clientId'] ?? '';
                          accessKeyController.text =
                              getConfigs['accessKey'] ?? '';
                          secretKeyController.text =
                              getConfigs['secretkey'] ?? '';
                          regionController.text = getConfigs['region'] ?? '';
                          _showConfigDialog('Configurações');
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Método que exibe mensagem de erro no login
  void _showDialogLogin(String title, String content) {
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

  void _showConfigDialog(String title) {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: Text(title),
        content: ScaffoldPage.scrollable(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Insira os dados abaixo:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormBox(
                  header: 'Código de cliente:',
                  controller: clientIdController,
                ),
                TextFormBox(
                  header: 'Chave de acesso:',
                  controller: accessKeyController,
                ),
                TextFormBox(
                  header: 'Chave secreta',
                  controller: secretKeyController,
                ),
                TextFormBox(
                  header: 'Região',
                  controller: regionController,
                )
              ],
            ),
          ],
        ),
        actions: [
          Button(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.pop(context);
              }),
          FilledButton(
              child: const Text('Salvar'),
              onPressed: () {
                setState(() {
                  ConfigService.saveSettings(
                      clientIdController.text,
                      accessKeyController.text,
                      secretKeyController.text,
                      regionController.text);
                  Navigator.pop(context);
                });
              })
        ],
      ),
    );
  }
}
