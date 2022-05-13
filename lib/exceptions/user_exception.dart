class EmailUserException implements Exception {
  String msg;
  EmailUserException(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class NameUserException implements Exception {
  String msg;
  NameUserException(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class PasswordUserException implements Exception {
  String msg;
  PasswordUserException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
