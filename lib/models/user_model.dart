class User {
  final String email;
  final String name;
  final String password;
  String? cpf;

  User(
      {required this.email,
      required this.name,
      required this.password,
      this.cpf});
}
