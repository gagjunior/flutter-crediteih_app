//Imports de terceiros
import 'package:realm/realm.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
//Imports do projeto
import 'package:crediteih_app/models/user_model.dart';
import 'package:crediteih_app/pages/home_page.dart';

import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late Realm realm;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  _LoginState() {
    final Configuration config = Configuration([User.schema]);
    realm = Realm(config);
    RealmResults<User> allUsers = realm.all<User>();

    // Verifica se existe algum usuário criado
    // Se não existir cria o usuário admin
    if (allUsers.isEmpty) {
      realm.write(() {
        User admin = User('admin@admin.com', 'admin', 'admin123456');
        realm.add(admin);
        //print("Usuário admin criado com sucesso: ${admin.email}, ${admin.name}");
      });
    } /* else {
      User admin = allUsers.query('email == "admin@admin.com"').elementAt(0);
      print('${admin.name}, ${admin.email}');
    } */
    realm.close();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
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
            // ignore: sized_box_for_whitespace
            Container(
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
            // ignore: sized_box_for_whitespace
            Container(
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
              onPressed: () {
                testeAws();
                //getCloudUsers(emailController.text, passwordController.text);
                bool usuarioAutenticado =
                    canAccess(emailController.text, passwordController.text);
                if (usuarioAutenticado) {
                  Navigator.push(
                      context,
                      FluentPageRoute(
                        builder: (context) => const HomePage(
                          title: 'Crediteih App',
                        ),
                      ));
                } else {
                  _showDialogLogin();
                }
              },
              style: ButtonStyle(
                padding: ButtonState.all(
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 10)),
                backgroundColor: ButtonState.resolveWith((states) {
                  if (states.isHovering) {
                    return const Color.fromARGB(255, 7, 55, 128);
                  } else {
                    return const Color.fromARGB(255, 10, 85, 247);
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método de login
  bool canAccess(String user, String password) {
    final Configuration config = Configuration([User.schema]);
    realm = Realm(config);
    RealmResults<User> allUsers = realm.all<User>();
    RealmResults<User> usuarioUtenticado =
        allUsers.query("email == '$user' AND password == '$password'");

    if (usuarioUtenticado.isNotEmpty) {
      realm.close();
      return true;
    }

    realm.close();
    return false;
  }

  // Método que exibe mensagem de erro no login
  void _showDialogLogin() {
    showDialog(
      context: context,
      builder: (_) => ContentDialog(
        title: const Text('Usuário e senha inválidos'),
        content: const Text('Confira o usuário e senha digitados'),
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

  Future<bool> getCloudUsers(String user, String password) async {
    final url = Uri.parse(
        'https://crediteihapp-default-rtdb.firebaseio.com/crediteih/users.json?print=pretty&key=AIzaSyCn0HImngZYaoKX6p2tY8Al16pivDWlhgo');
    var response = await http.get(url);
    var responseJson = convert.jsonDecode(response.body);
    var usuario = responseJson?[user];
    if (usuario == null) {
      print('usuario não encontrado');
      return false;
    } else {
      var senha = usuario['password'];
      print(senha);
      print(usuario);
    }

    return false;
  }

  Future<void> testeAws() async {
    final AwsClientCredentials credentials = AwsClientCredentials(
        accessKey: 'AKIAVIYQ2KF7CZC4DNPX',
        secretKey: '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');
    final service = DynamoDB(region: 'sa-east-1', credentials: credentials);

    var resposta = await service.getItem(
        key: {'email': AttributeValue(s: 'admin@admin.com')},
        tableName: 'users');

    var respostaJson = resposta.item?['name']?.s;
    print(respostaJson);
  }
}
