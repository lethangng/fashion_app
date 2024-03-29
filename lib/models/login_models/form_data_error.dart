class FormDataError {
  String name;
  String email;
  String password;

  FormDataError({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(covariant FormDataError other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ password.hashCode;
  }
}
