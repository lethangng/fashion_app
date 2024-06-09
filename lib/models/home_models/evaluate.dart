// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Evaluate {
  final int id;
  final String fullname;
  final int star_number;
  final String? content;
  final String? image_url;
  final String created_at;

  Evaluate({
    required this.id,
    required this.fullname,
    required this.star_number,
    this.content,
    this.image_url,
    required this.created_at,
  });

  Evaluate copyWith({
    int? id,
    String? fullname,
    int? star_number,
    String? content,
    String? image_url,
    String? created_at,
  }) {
    return Evaluate(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      star_number: star_number ?? this.star_number,
      content: content ?? this.content,
      image_url: image_url ?? this.image_url,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'star_number': star_number,
      'content': content,
      'image_url': image_url,
      'created_at': created_at,
    };
  }

  factory Evaluate.fromMap(Map<String, dynamic> map) {
    return Evaluate(
      id: map['id'] as int,
      fullname: map['fullname'] as String,
      star_number: map['star_number'] as int,
      content: map['content'] != null ? map['content'] as String : null,
      image_url: map['image_url'] != null ? map['image_url'] as String : null,
      created_at: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Evaluate.fromJson(String source) =>
      Evaluate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Evaluate(id: $id, fullname: $fullname, star_number: $star_number, content: $content, image_url: $image_url, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant Evaluate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullname == fullname &&
        other.star_number == star_number &&
        other.content == content &&
        other.image_url == image_url &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        star_number.hashCode ^
        content.hashCode ^
        image_url.hashCode ^
        created_at.hashCode;
  }
}

class ListEvaluate {
  final num average_evaluate;
  final int count;
  final int star_1;
  final int star_2;
  final int star_3;
  final int star_4;
  final int star_5;
  final List<Evaluate> evaluates;

  ListEvaluate({
    required this.average_evaluate,
    required this.count,
    required this.star_1,
    required this.star_2,
    required this.star_3,
    required this.star_4,
    required this.star_5,
    required this.evaluates,
  });

  ListEvaluate copyWith({
    num? average_evaluate,
    int? count,
    int? star_1,
    int? star_2,
    int? star_3,
    int? star_4,
    int? star_5,
    List<Evaluate>? evaluates,
  }) {
    return ListEvaluate(
      average_evaluate: average_evaluate ?? this.average_evaluate,
      count: count ?? this.count,
      star_1: star_1 ?? this.star_1,
      star_2: star_2 ?? this.star_2,
      star_3: star_3 ?? this.star_3,
      star_4: star_4 ?? this.star_4,
      star_5: star_5 ?? this.star_5,
      evaluates: evaluates ?? this.evaluates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'average_evaluate': average_evaluate,
      'count': count,
      'star_1': star_1,
      'star_2': star_2,
      'star_3': star_3,
      'star_4': star_4,
      'star_5': star_5,
      'evaluates': evaluates.map((x) => x.toMap()).toList(),
    };
  }

  factory ListEvaluate.fromMap(Map<String, dynamic> map) {
    return ListEvaluate(
      average_evaluate: map['average_evaluate'] as num,
      count: map['count'] as int,
      star_1: map['star_1'] as int,
      star_2: map['star_2'] as int,
      star_3: map['star_3'] as int,
      star_4: map['star_4'] as int,
      star_5: map['star_5'] as int,
      evaluates: List<Evaluate>.from(
        (map['evaluates'] as List).map<Evaluate>(
          (x) => Evaluate.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListEvaluate.fromJson(String source) =>
      ListEvaluate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListEvaluate(average_evaluate: $average_evaluate, count: $count, star_1: $star_1, star_2: $star_2, star_3: $star_3, star_4: $star_4, star_5: $star_5, evaluates: $evaluates)';
  }

  @override
  bool operator ==(covariant ListEvaluate other) {
    if (identical(this, other)) return true;

    return other.average_evaluate == average_evaluate &&
        other.count == count &&
        other.star_1 == star_1 &&
        other.star_2 == star_2 &&
        other.star_3 == star_3 &&
        other.star_4 == star_4 &&
        other.star_5 == star_5 &&
        listEquals(other.evaluates, evaluates);
  }

  @override
  int get hashCode {
    return average_evaluate.hashCode ^
        count.hashCode ^
        star_1.hashCode ^
        star_2.hashCode ^
        star_3.hashCode ^
        star_4.hashCode ^
        star_5.hashCode ^
        evaluates.hashCode;
  }
}
