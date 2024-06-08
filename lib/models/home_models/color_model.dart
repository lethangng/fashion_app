// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ColorModel {
  final int id;
  final String name;
  final String color;

  ColorModel({
    required this.id,
    required this.name,
    required this.color,
  });

  ColorModel copyWith({
    int? id,
    String? name,
    String? color,
  }) {
    return ColorModel(
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

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Color(id: $id, name: $name, color: $color)';

  @override
  bool operator ==(covariant ColorModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.color == color;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;
}
