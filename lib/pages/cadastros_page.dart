import 'package:fluent_ui/fluent_ui.dart';

const Widget spacer = SizedBox(height: 5.0);

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({Key? key}) : super(key: key);

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text(
          'Cadastros',
          style: TextStyle(
            color: Color.fromARGB(255, 42, 93, 245),
            fontSize: 18,
          ),
        ),
      ),
      children: [
        Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.start,
          spacing: 14,
          runSpacing: 14,
          children: [
            _createCard('Cadastro de Usuários'),
            _createCard('Cadastro de NCM'),
          ],
        ),
      ],
    );
  }

  Widget _createCard(String titulo) {
    const double splitButtonHeight = 25.0;
    return Card(
      child: InfoLabel(
        label: titulo,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        isHeader: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacer,
            FilledButton(
              child: const Text('Acessar'),
              onPressed: disabled ? null : () => print('pressed filled button'),
            ),
            spacer,
            DropDownButton(
              disabled: disabled,
              leading: const Icon(FluentIcons.mail),
              items: [
                DropDownButtonItem(
                  title: const Text('Send'),
                  leading: const Icon(FluentIcons.send),
                  onTap: () => debugPrint('Send'),
                ),
                DropDownButtonItem(
                  title: const Text('Reply'),
                  leading: const Icon(FluentIcons.mail_reply),
                  onTap: () => debugPrint('Reply'),
                ),
                DropDownButtonItem(
                  title: const Text('Reply all'),
                  leading: const Icon(FluentIcons.mail_reply_all),
                  onTap: () => debugPrint('Reply all'),
                ),
              ],
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
