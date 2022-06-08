import 'package:fluent_ui/fluent_ui.dart';

Widget leadingPageHeader(void Function()? onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: IconButton(
      icon: const Icon(
        FluentIcons.back,
        size: 20,
        color: Color.fromARGB(255, 10, 34, 255),
      ),
      onPressed: onPressed,
    ),
  );
}

Widget titlePageHeader(IconData? icon, String titulo, String subtitulo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        icon != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(
                  icon,
                  size: 26,
                  color: const Color.fromARGB(255, 10, 34, 255),
                ),
              )
            : const Text(''),
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
          if (states.isNone) {
            return Colors.blue.normal;
          }
          if (states.isHovering) {
            return Colors.blue.darker;
          }
          return null;
        }),
        foregroundColor: ButtonState.resolveWith((states) {
          if (states.isNone || states.isHovering) {
            return Colors.white;
          }
          return null;
        }),
      ),
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

Widget titleCardInitialPage(String title, IconData icon) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 20,
        ),
      ),
      Expanded(
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}

Widget rowCardInitialPage(String content) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
    child: Text(
      content,
      softWrap: true,
      textAlign: TextAlign.left,
      style: const TextStyle(fontSize: 14),
    ),
  );
}

Widget cardInitialPage(void Function()? onPressed, List<Widget> contents) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: SizedBox(
      width: 300,
      height: 250,
      child: Button(
        style: ButtonStyle(
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isNone) {
              return Colors.blue.normal;
            }
            if (states.isHovering) {
              return Colors.blue.darker;
            }
            return null;
          }),
          foregroundColor: ButtonState.resolveWith((states) {
            if (states.isNone || states.isHovering) {
              return Colors.white;
            }
            return null;
          }),
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: contents,
        ),
      ),
    ),
  );
}
