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
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: titlePageHeader(
            FluentIcons.home_solid, 'Menu Inicial', 'Crediteih App'),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 250,
                child: Button(
                  style: ButtonStyle(
                      backgroundColor: ButtonState.resolveWith((states) {
                    if (states.isNone) {
                      return material.Colors.teal[100];
                    }
                    if (states.isHovering) {
                      return material.Colors.blue[100];
                    }
                    return null;
                  })),
                  onPressed: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      titleCardInitialPage(
                          'Cadastro de Usuários', FluentIcons.add_multiple),
                      const SizedBox(height: 20),
                      rowCardInitialPage(
                          '- Gerencie todos cadastros do aplicativo'),
                      rowCardInitialPage('- Cadastro de usuários'),
                      rowCardInitialPage('- Cadastro de clientes'),
                      rowCardInitialPage('... e muito mais!'),
                      const SizedBox(height: 20),
                      rowCardInitialPage('Clique e acesse o menu de cadastros')
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 250,
                child: Button(
                  style: ButtonStyle(
                      backgroundColor: ButtonState.resolveWith((states) {
                    if (states.isNone) {
                      return material.Colors.teal[200];
                    }
                    if (states.isHovering) {
                      return material.Colors.blue[200];
                    }
                    return null;
                  })),
                  onPressed: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      titleCardInitialPage(
                          'Relatórios', FluentIcons.report_document),
                      const SizedBox(height: 20),
                      rowCardInitialPage(
                          '- Acesse todos os relatórios do aplicativo'),
                      //rowCardInitialPage('- Cadastro de usuários'),
                      //rowCardInitialPage('- Cadastro de clientes'),
                      rowCardInitialPage('... e muito mais!'),
                      const SizedBox(height: 20),
                      rowCardInitialPage('Clique e acesse o menu de relatórios')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
