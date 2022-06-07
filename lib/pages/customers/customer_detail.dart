import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomerDetail extends StatefulWidget {
  const CustomerDetail({Key? key}) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  String name = '';
  String email = '';
  final Box customerBox = Hive.box('customer');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = customerBox.get('customer')['name'];
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          child: IconButton(
            icon: const Icon(
              FluentIcons.back,
              size: 20,
              color: Color.fromARGB(255, 10, 34, 255),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: titlePageHeader(FluentIcons.list_mirrored, name, 'Dados gerais'),
      ),
      children: [],
    );
  }
}
