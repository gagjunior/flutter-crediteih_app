import 'package:fluent_ui/fluent_ui.dart';

Widget createButtonMenuPage(String titulo, String subtitulo) {
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
