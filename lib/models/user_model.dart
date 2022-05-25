class User {
  final String? email;
  final String? name;
  final String? password;
  late final String? cpf;
  late final Map<String, dynamic>? address;

  User(
      {required this.email,
      required this.name,
      required this.password,
      this.cpf,
      this.address});
}
