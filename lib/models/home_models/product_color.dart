// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import '../shop_models/filters.dart';

class ProductColor {
  final int id;
  final String name;
  final String color;

  ProductColor({
    required this.id,
    required this.name,
    required this.color,
  });

  ProductColor copyWith({
    int? id,
    String? name,
    String? color,
  }) {
    return ProductColor(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
    };
  }

  factory ProductColor.fromMap(Map<String, dynamic> map) {
    return ProductColor(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductColor.fromJson(String source) =>
      ProductColor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Color(id: $id, name: $name, color: $color)';

  @override
  bool operator ==(covariant ProductColor other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.color == color;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;
}
