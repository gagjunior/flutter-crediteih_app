import 'package:crediteih_app/pages/menus/records_page.dart';
import 'package:crediteih_app/pages/menus/reports_page.dart';
import 'package:crediteih_app/pages/shared_widgets.dart';
import 'package:crediteih_app/pages/users/user_cad.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class InicialPage extends StatefulWidget {
  const InicialPage({Key? key}) : super(key: key);

  @override
  State<InicialPage> createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: titlePageHeader(
            FluentIcons.home_solid, 'Menu Inicial', 'Crediteih App'),
      ),
      content: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          material.Card(
            margin: const EdgeInsets.all(8),
            color: material.Colors.blue[100],
            child: const Text("He'd have you all unravel at the"),
          ),
          material.Card(
            margin: const EdgeInsets.all(8),
            color: material.Colors.blue[200],
            child: const Text('Heed not the rabble'),
          ),
          material.Card(
            margin: const EdgeInsets.all(8),
            color: material.Colors.blue[300],
            child: const Text('Sound of screams but the'),
          ),
        ],
      ),
    );
  }
}
