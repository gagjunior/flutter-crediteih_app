import 'package:fluent_ui/fluent_ui.dart';

Widget titlePageHeader(IconData icon, String titulo, String subtitulo) {
  return Padding(
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 26,
                color: Color.fromARGB(255, 10, 34, 255),
              ),
            ),
            Text(
              subtitulo,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 26,
            color: const Color.fromARGB(255, 10, 34, 255),
          ),
        ),
      ],
    ),
    padding: const EdgeInsets.all(8.0),
  );
}

Widget buttonMenuPage(String titulo, String subtitulo) {
  return Button(
    style: ButtonStyle(
      elevation: ButtonState.all(4),
    ),
    child: Row(
      children: [
        Icon(
          FluentIcons.group,
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
    onPressed: () {},
  );
}
