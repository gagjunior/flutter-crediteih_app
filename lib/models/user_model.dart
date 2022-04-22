import 'package:realm/realm.dart';

part 'user_model.g.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late final String email;

  @Indexed()
  late String name;

  late String password;

  @Indexed()
  late String? cpf;
}
