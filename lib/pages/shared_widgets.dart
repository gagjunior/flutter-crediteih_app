import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

Future<bool> getCloudUsers(String user, String password) async {
  final url = Uri.parse(
      'https://data.mongodb-api.com/app/data-uhnoa/endpoint/data/beta/action/findOne');
  final headers = {
    'Content-Type': 'application/json',
    'Access-Control-Request-Headers': '*',
    'api-key':
        'Veyz7RSLg6PXeaFl8QJ4G0mIP3mfxq64UaysYVqz8XIbcM34yfnNVJ2NruAh63DH'
  };
  final body = {
    'collection': 'users',
    'database': 'crediteih_app',
    'dataSource': 'CrediteihApp'
  };

  var response =
      await http.post(url, headers: headers, body: convert.jsonEncode(body));
  var jsonResponse = convert.jsonDecode(response.body);

  var email = jsonResponse["document"]["email"].toString();
  var senha = jsonResponse["document"]["senha"].toString();

  print(email);
  print(senha);

  if (email == user && senha == password) {
    return true;
  } else {
    return false;
  }
}
