// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductSize {
  final int id;
  final String size;

  ProductSize({
    required this.id,
    required this.size,
  });

  ProductSize copyWith({
    int? id,
    String? size,
  }) {
    return ProductSize(
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

  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      id: map['id'] as int,
      size: map['size'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSize.fromJson(String source) =>
      ProductSize.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SizeModel(id: $id, size: $size)';

  @override
  bool operator ==(covariant ProductSize other) {
    if (identical(this, other)) return true;

    return other.id == id && other.size == size;
  }

  @override
  int get hashCode => id.hashCode ^ size.hashCode;
}
