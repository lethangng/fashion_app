// ignore_for_file: public_member_api_docs, sort_constructors_first
class FormDataError {
  String name;
  String email;
  String password;
  String confirmPassword;

  FormDataError({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  bool operator ==(covariant FormDataError other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode;
  }
}
