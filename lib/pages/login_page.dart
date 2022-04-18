import 'package:realm/realm.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:email_validator/email_validator.dart';
import 'package:crediteih_app/pages/home_page.dart';
import 'package:crediteih_app/models/models.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late Realm realm;
  TextEditingController emailController = TextEditingController();

  _LoginState() {
    final config = Configuration([User.schema]);
    realm = Realm(config);
    var allUsers = realm.all<User>();

    if (allUsers.isEmpty) {
      realm.write(() {
        User admin = User('admin@admin', 'admin', '123456');
        realm.add(admin);
        print(
            "Usuário admin criado com sucesso: ${admin.email}, ${admin.name}");
      });
    } else {
      var admin = allUsers.query('email == "admin@admin"').elementAt(0);
      print('${admin.name}, ${admin.email}');
    }

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
                  controller: emailController,
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
                child: TextBox(
                  textAlignVertical: TextAlignVertical.center,
                  header: 'Senha',
                  minHeight: 40,
                  cursorHeight: 26,
                  obscureText: true,
                  obscuringCharacter: '◉',
                  cursorColor: Colors.blue,
                  placeholder: 'Digite sua senha...',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      FluentIcons.password_field,
                      color: Color.fromRGBO(0, 64, 255, 1.0),
                      size: 24,
                    ),
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
                Navigator.push(
                    context,
                    FluentPageRoute(
                      builder: (context) => const HomePage(
                        title: 'Crediteih App',
                      ),
                    ));
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
}
