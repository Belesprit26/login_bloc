class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);

  @override
  String toString() {
    return "UserNotFoundException: $message";
  }
}
