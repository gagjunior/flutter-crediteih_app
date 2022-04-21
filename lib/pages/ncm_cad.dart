import 'package:fluent_ui/fluent_ui.dart';

class NcmCadPage extends StatefulWidget {
  const NcmCadPage({Key? key}) : super(key: key);

  @override
  State<NcmCadPage> createState() => _NcmCadPageState();
}

class _NcmCadPageState extends State<NcmCadPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Text('Cadastro de NCM'),
      ],
    );
  }
}
