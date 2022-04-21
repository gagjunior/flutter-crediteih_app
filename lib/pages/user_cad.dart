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
      padding: EdgeInsets.all(6),
      header: PageHeader(
        title: Text('Cadastro de Usuários'),
      ),
      children: [],
    );
  }
}
