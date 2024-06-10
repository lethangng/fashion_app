enum PasswordError {
  long,
  sort,
  // format,
  isNull,
}

class Validate {
  static PasswordError validatePassword(String password) {
    if (password.length < 6) {
      return PasswordError.sort;
    } else if (password.length > 20) {
      return PasswordError.long;
      // } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[^\w\d\s]).{6,20}$')
      //     .hasMatch(password)) {
      //   return PasswordError.format;
    } else {
      return PasswordError.isNull;
    }
  }

  static bool validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static bool checkNullEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }
}
