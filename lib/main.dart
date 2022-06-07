import 'package:crediteih_app/pages/login_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('loggedUser');
  await Hive.openBox('customer');
  runApp(const CrediteihApp());
}

class CrediteihApp extends StatelessWidget {
  const CrediteihApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Crediteih App',
      home: const LoginPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
        focusTheme: FocusThemeData(
          glowFactor: 3.0,
          glowColor: SystemTheme.accentColor.accent.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          primaryBorder: BorderSide.none,
        ),
      ),
    );
  }
}
