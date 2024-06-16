// ignore_for_file: public_member_api_docs, sort_constructors_first
class PasswordDataError {
  String oldPassword;
  String newPassword;
  String confirmPassword;

  PasswordDataError({
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  @override
  bool operator ==(covariant PasswordDataError other) {
    if (identical(this, other)) return true;

    return other.oldPassword == oldPassword &&
        other.newPassword == newPassword &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode =>
      oldPassword.hashCode ^ newPassword.hashCode ^ confirmPassword.hashCode;
}
