import 'package:realm/realm.dart';

part 'user_model.g.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late final String email;

  @Indexed()
  late final String name;

  late String password;

  @Indexed()
  late String? cpf;
}
