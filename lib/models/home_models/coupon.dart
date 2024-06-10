// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Coupon {
  final int id;
  final String name;
  final String code;
  final int price;
  final int for_sum;
  final int coupon_type;
  final String expired;
  final String? desc;

  Coupon({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.for_sum,
    required this.coupon_type,
    required this.expired,
    this.desc,
  });

  Coupon copyWith({
    int? id,
    String? name,
    String? code,
    int? price,
    int? for_sum,
    int? coupon_type,
    String? expired,
    String? desc,
  }) {
    return Coupon(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      for_sum: for_sum ?? this.for_sum,
      coupon_type: coupon_type ?? this.coupon_type,
      expired: expired ?? this.expired,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'price': price,
      'for_sum': for_sum,
      'coupon_type': coupon_type,
      'expired': expired,
      'desc': desc,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
      price: map['price'] as int,
      for_sum: map['for_sum'] as int,
      coupon_type: map['coupon_type'] as int,
      expired: map['expired'] as String,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupon.fromJson(String source) =>
      Coupon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coupon(id: $id, name: $name, code: $code, price: $price, for_sum: $for_sum, coupon_type: $coupon_type, expired: $expired, desc: $desc)';
  }

  @override
  bool operator ==(covariant Coupon other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.code == code &&
        other.price == price &&
        other.for_sum == for_sum &&
        other.coupon_type == coupon_type &&
        other.expired == expired &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        price.hashCode ^
        for_sum.hashCode ^
        coupon_type.hashCode ^
        expired.hashCode ^
        desc.hashCode;
  }
}
