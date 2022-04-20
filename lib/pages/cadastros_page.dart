import 'package:fluent_ui/fluent_ui.dart';

const Widget spacer = SizedBox(height: 6.0);

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
      children: [],
    );
  }
}
