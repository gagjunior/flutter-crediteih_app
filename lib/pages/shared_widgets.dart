import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

Widget titlePageHeader(IconData icon, String titulo, String subtitulo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Icon(
            icon,
            size: 26,
            color: const Color.fromARGB(255, 10, 34, 255),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              softWrap: true,
              style: const TextStyle(
                fontSize: 26,
                color: Color.fromARGB(255, 10, 34, 255),
              ),
            ),
            Text(
              subtitulo,
              softWrap: true,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buttonMenuPage(String titulo, String subtitulo, Widget page,
    BuildContext context, IconData icon) {
  return Button(
      style: ButtonStyle(
          elevation: ButtonState.all(4),
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isNone) return material.Colors.blue[50];
          })),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              semanticLabel: titulo,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitulo,
                ),
              ],
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context, FluentPageRoute(builder: (context) => page));
      });
}
