// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SizeModel {
  final int id;
  final String size;

  SizeModel({
    required this.id,
    required this.size,
  });

  SizeModel copyWith({
    int? id,
    String? size,
  }) {
    return SizeModel(
      id: id ?? this.id,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'size': size,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      id: map['id'] as int,
      size: map['size'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeModel.fromJson(String source) =>
      SizeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SizeModel(id: $id, size: $size)';

  @override
  bool operator ==(covariant SizeModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.size == size;
  }

  @override
  int get hashCode => id.hashCode ^ size.hashCode;
}
