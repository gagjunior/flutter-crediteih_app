class LoginUserException implements Exception {
  String msg;
  LoginUserException(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class LoginPasswordException implements Exception {
  String msg;
  LoginPasswordException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
