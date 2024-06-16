// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'order_product.dart';

class OrderInfo {
  final int id;
  final int count;
  final int status;
  final String status_title;
  final int total_price;
  final int price_off;
  final String delivery_address;
  final int is_evaluate;
  final String created_at;

  OrderInfo({
    required this.id,
    required this.count,
    required this.status,
    required this.status_title,
    required this.total_price,
    required this.price_off,
    required this.delivery_address,
    required this.is_evaluate,
    required this.created_at,
  });

  OrderInfo copyWith({
    int? id,
    int? count,
    int? status,
    String? status_title,
    int? total_price,
    int? price_off,
    String? delivery_address,
    int? is_evaluate,
    String? created_at,
  }) {
    return OrderInfo(
      id: id ?? this.id,
      count: count ?? this.count,
      status: status ?? this.status,
      status_title: status_title ?? this.status_title,
      total_price: total_price ?? this.total_price,
      price_off: price_off ?? this.price_off,
      delivery_address: delivery_address ?? this.delivery_address,
      is_evaluate: is_evaluate ?? this.is_evaluate,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'count': count,
      'status': status,
      'status_title': status_title,
      'total_price': total_price,
      'price_off': price_off,
      'delivery_address': delivery_address,
      'is_evaluate': is_evaluate,
      'created_at': created_at,
    };
  }

  factory OrderInfo.fromMap(Map<String, dynamic> map) {
    return OrderInfo(
      id: map['id'] as int,
      count: map['count'] as int,
      status: map['status'] as int,
      status_title: map['status_title'] as String,
      total_price: map['total_price'] as int,
      price_off: map['price_off'] as int,
      delivery_address: map['delivery_address'] as String,
      is_evaluate: map['is_evaluate'] as int,
      created_at: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderInfo.fromJson(String source) =>
      OrderInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderInfo(id: $id, count: $count, status: $status, status_title: $status_title, total_price: $total_price, price_off: $price_off, delivery_address: $delivery_address, is_evaluate: $is_evaluate, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant OrderInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.count == count &&
        other.status == status &&
        other.status_title == status_title &&
        other.total_price == total_price &&
        other.price_off == price_off &&
        other.delivery_address == delivery_address &&
        other.is_evaluate == is_evaluate &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        count.hashCode ^
        status.hashCode ^
        status_title.hashCode ^
        total_price.hashCode ^
        price_off.hashCode ^
        delivery_address.hashCode ^
        is_evaluate.hashCode ^
        created_at.hashCode;
  }
}

class OrderDetail {
  final OrderInfo order_info;
  final List<OrderProduct> order_list;

  OrderDetail({
    required this.order_info,
    required this.order_list,
  });

  OrderDetail copyWith({
    OrderInfo? order_info,
    List<OrderProduct>? order_list,
  }) {
    return OrderDetail(
      order_info: order_info ?? this.order_info,
      order_list: order_list ?? this.order_list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_info': order_info.toMap(),
      'order_list': order_list.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      order_info: OrderInfo.fromMap(map['order_info'] as Map<String, dynamic>),
      order_list: List<OrderProduct>.from(
        (map['order_list'] as List).map<OrderProduct>(
          (x) => OrderProduct.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderDetail(order_info: $order_info, order_list: $order_list)';

  @override
  bool operator ==(covariant OrderDetail other) {
    if (identical(this, other)) return true;

    return other.order_info == order_info &&
        listEquals(other.order_list, order_list);
  }

  @override
  int get hashCode => order_info.hashCode ^ order_list.hashCode;
}
