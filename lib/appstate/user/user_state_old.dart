abstract class UserStatus extends RepresentableError {
  const UserStatus();
}

class EmptyUserState extends UserStatus {
  const EmptyUserState();
}

abstract class RepresentableError {
  const RepresentableError();
}

abstract class LoginErrorType extends UserStatus {
  String basicDescription();

  static LoginErrorType invalidUserName() => InvalidUserName();
  static LoginErrorType invalidPassword() => InvalidPassword();
  static LoginErrorType unknownError() => UnknownError();
}

class UnknownError extends LoginErrorType {
  @override
  String basicDescription() {
    return "Unknown Error";
  }
}

class InvalidUserName extends LoginErrorType {
  InvalidUserName();

  @override
  String basicDescription() {
    return 'Invalid Username';
  }
}

class InvalidPassword extends LoginErrorType {
  @override
  String basicDescription() {
    return "Invalid Password";
  }
}

class EmptyUser extends UserStatus {
  final String e;
  const EmptyUser({required this.e});

  String get message => e;

  @override
  String toString() {
    return message;
  }
}

class EmptyUserError extends RepresentableError {
  final String e;
  const EmptyUserError({required this.e});

  String get message => e;

  @override
  String toString() {
    return message;
  }
}
