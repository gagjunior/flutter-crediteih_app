import 'package:fluent_ui/fluent_ui.dart';

const Widget spacer = SizedBox(height: 6.0);

class UserCadPage extends StatefulWidget {
  const UserCadPage({Key? key}) : super(key: key);

  @override
  State<UserCadPage> createState() => _UserCadPageState();
}

class _UserCadPageState extends State<UserCadPage> {
  bool disabled = false;

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
        Wrap(
          direction: Axis.vertical,
          spacing: 10,
          children: [
            Container(
              width: 600,
              child: TextFormBox(
                keyboardType: TextInputType.text,
                header: 'Nome',
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              width: 600,
              child: TextFormBox(
                header: 'E-mail',
              ),
            ),
            Container(
              width: 300,
              child: TextFormBox(
                header: 'CPF',
                maxLength: 15,
                autofocus: true,
              ),
            ),
          ],
        )
      ],
    );
  }
}
