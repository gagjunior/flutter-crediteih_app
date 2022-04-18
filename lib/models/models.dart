import 'package:realm/realm.dart';

part 'models.g.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late final String email;

  @Indexed()
  late String name;

  @Indexed()
  late String? cpf;

  late String password;
}
