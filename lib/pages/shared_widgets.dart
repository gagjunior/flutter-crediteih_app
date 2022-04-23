import 'package:fluent_ui/fluent_ui.dart';

PageHeader headerPage(IconData icon, String titulo, String subtitulo) {
  return PageHeader(
    title: Padding(
      child: Column(
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
      padding: const EdgeInsets.all(8.0),
    ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        size: 26,
        color: const Color.fromARGB(255, 10, 34, 255),
      ),
    ),
  );
}
