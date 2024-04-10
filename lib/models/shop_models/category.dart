import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  String title;
  String image;

  Category({
    required this.title,
    required this.image,
  });

  Category copyWith({
    String? title,
    String? image,
  }) {
    return Category(
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
