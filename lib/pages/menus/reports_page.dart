import 'package:crediteih_app/pages/home_page.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';

const Widget separator = SizedBox(height: 10);

class ReportsMenuPage extends StatefulWidget {
  const ReportsMenuPage({Key? key}) : super(key: key);

  @override
  State<ReportsMenuPage> createState() => _ReportsMenuPageState();
}

class _ReportsMenuPageState extends State<ReportsMenuPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      padding: const EdgeInsets.all(6),
      header: PageHeader(
        leading: leadingPageHeader((() {
          Navigator.push(
              context, FluentPageRoute(builder: (context) => const HomePage()));
        })),
        title: titlePageHeader(FluentIcons.report_document, 'Relatórios',
            'Lista de relatórios disponiveis no sistema'),
      ),
      children: const [],
    );
  }
}
