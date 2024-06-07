// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestData {
  final String query;
  final Map<String, dynamic> data;

  RequestData({
    required this.query,
    required this.data,
  });

  RequestData copyWith({
    String? query,
    Map<String, dynamic>? data,
  }) {
    return RequestData(
      query: query ?? this.query,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      'data': data,
    };
  }

  factory RequestData.fromMap(Map<String, dynamic> map) {
    return RequestData(
      query: map['query'] as String,
      data: Map<String, dynamic>.from((map['data'] as Map<String, dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestData.fromJson(String source) =>
      RequestData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RequestData(query: $query, data: $data)';

  @override
  bool operator ==(covariant RequestData other) {
    if (identical(this, other)) return true;

    return other.query == query && mapEquals(other.data, data);
  }

  @override
  int get hashCode => query.hashCode ^ data.hashCode;
}
