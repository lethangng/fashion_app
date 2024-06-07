// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String u_id;
  final String fullname;
  final String email;
  final String? image;
  final String login_type;

  User({
    required this.id,
    required this.u_id,
    required this.fullname,
    required this.email,
    required this.image,
    required this.login_type,
  });

  User copyWith({
    int? id,
    String? u_id,
    String? fullname,
    String? email,
    String? image,
    String? login_type,
  }) {
    return User(
      id: id ?? this.id,
      u_id: u_id ?? this.u_id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      image: image ?? this.image,
      login_type: login_type ?? this.login_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'u_id': u_id,
      'fullname': fullname,
      'email': email,
      'image': image,
      'login_type': login_type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      u_id: map['u_id'] as String,
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      login_type: map['login_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, u_id: $u_id, fullname: $fullname, email: $email, image: $image, login_type: $login_type)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.u_id == u_id &&
        other.fullname == fullname &&
        other.email == email &&
        other.image == image &&
        other.login_type == login_type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        u_id.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        image.hashCode ^
        login_type.hashCode;
  }
}
