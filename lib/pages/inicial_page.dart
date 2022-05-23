import 'package:crediteih_app/pages/shared_widgets.dart';
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
          Card(
            padding: const EdgeInsets.all(8),
            backgroundColor: material.Colors.blue[100],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: material.Colors.blue[800],
                        child: const Text(
                          'Cadastro de Usuários',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Card(
            padding: const EdgeInsets.all(8),
            backgroundColor: material.Colors.blue[200],
            child: const Text('Heed not the rabble'),
          ),
          Card(
            padding: const EdgeInsets.all(8),
            backgroundColor: material.Colors.blue[300],
            child: const Text('Sound of screams but the'),
          ),
        ],
      ),
    );
  }
}
