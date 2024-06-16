// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../home_models/product_color.dart';
import '../home_models/product_size.dart';

class OrderProduct {
  final int product_id;
  final String product_name;
  final String brand;
  final int quantity;
  final int price;
  final String image_url;
  final ProductColor color;
  final ProductSize size;

  OrderProduct({
    required this.product_id,
    required this.product_name,
    required this.brand,
    required this.quantity,
    required this.price,
    required this.image_url,
    required this.color,
    required this.size,
  });

  OrderProduct copyWith({
    int? product_id,
    String? product_name,
    String? brand,
    int? quantity,
    int? price,
    String? image_url,
    ProductColor? color,
    ProductSize? size,
  }) {
    return OrderProduct(
      product_id: product_id ?? this.product_id,
      product_name: product_name ?? this.product_name,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      image_url: image_url ?? this.image_url,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'product_name': product_name,
      'brand': brand,
      'quantity': quantity,
      'price': price,
      'image_url': image_url,
      'color': color.toMap(),
      'size': size.toMap(),
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      product_id: map['product_id'] as int,
      product_name: map['product_name'] as String,
      brand: map['brand'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      image_url: map['image_url'] as String,
      color: ProductColor.fromMap(map['color'] as Map<String, dynamic>),
      size: ProductSize.fromMap(map['size'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProduct.fromJson(String source) =>
      OrderProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProduct(product_id: $product_id, product_name: $product_name, brand: $brand, quantity: $quantity, price: $price, image_url: $image_url, color: $color, size: $size)';
  }

  @override
  bool operator ==(covariant OrderProduct other) {
    if (identical(this, other)) return true;

    return other.product_id == product_id &&
        other.product_name == product_name &&
        other.brand == brand &&
        other.quantity == quantity &&
        other.price == price &&
        other.image_url == image_url &&
        other.color == color &&
        other.size == size;
  }

  @override
  int get hashCode {
    return product_id.hashCode ^
        product_name.hashCode ^
        brand.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        image_url.hashCode ^
        color.hashCode ^
        size.hashCode;
  }
}
