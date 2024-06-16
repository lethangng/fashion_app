// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'order_product.dart';

class Order {
  final int id;
  final OrderProduct order_info;
  final String created_at;
  final int total_price;
  final int count;
  final int status;
  final String status_title;

  Order({
    required this.id,
    required this.order_info,
    required this.created_at,
    required this.total_price,
    required this.count,
    required this.status,
    required this.status_title,
  });

  Order copyWith({
    int? id,
    OrderProduct? order_info,
    String? created_at,
    int? total_price,
    int? count,
    int? status,
    String? status_title,
  }) {
    return Order(
      id: id ?? this.id,
      order_info: order_info ?? this.order_info,
      created_at: created_at ?? this.created_at,
      total_price: total_price ?? this.total_price,
      count: count ?? this.count,
      status: status ?? this.status,
      status_title: status_title ?? this.status_title,
    );
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      order_info:
          OrderProduct.fromMap(map['order_info'] as Map<String, dynamic>),
      created_at: map['created_at'] as String,
      total_price: map['total_price'] as int,
      count: map['count'] as int,
      status: map['status'] as int,
      status_title: map['status_title'] as String,
    );
  }

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, order_info: $order_info, created_at: $created_at, total_price: $total_price, count: $count, status: $status, status_title: $status_title)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.order_info == order_info &&
        other.created_at == created_at &&
        other.total_price == total_price &&
        other.count == count &&
        other.status == status &&
        other.status_title == status_title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order_info.hashCode ^
        created_at.hashCode ^
        total_price.hashCode ^
        count.hashCode ^
        status.hashCode ^
        status_title.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_info': order_info.toMap(),
      'created_at': created_at,
      'total_price': total_price,
      'count': count,
      'status': status,
      'status_title': status_title,
    };
  }

  String toJson() => json.encode(toMap());
}
