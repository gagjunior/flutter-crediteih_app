class ConfigException implements Exception {
  String msg;

  ConfigException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
