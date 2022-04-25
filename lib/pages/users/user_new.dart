import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.all(6),
      header: PageHeader(
        leading: IconButton(
          icon: Icon(
            FluentIcons.back,
            size: 20,
            color: Color.fromARGB(255, 10, 34, 255),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titlePageHeader(FluentIcons.user_followed, 'Novo Usuário',
            'Cadastre um novo usuário'),
      ),
      children: const [],
    );
  }
}
