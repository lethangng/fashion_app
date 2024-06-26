// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'product_color.dart';
import 'product_size.dart';

class ExtraProduct {
  final int size;
  final int color;
  ExtraProduct({
    required this.size,
    required this.color,
  });

  ExtraProduct copyWith({
    int? size,
    int? color,
  }) {
    return ExtraProduct(
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'size': size,
      'color': color,
    };
  }

  factory ExtraProduct.fromMap(Map<String, dynamic> map) {
    return ExtraProduct(
      size: map['size'] as int,
      color: map['color'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExtraProduct.fromJson(String source) =>
      ExtraProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ExtraProduct(size: $size, color: $color)';

  @override
  bool operator ==(covariant ExtraProduct other) {
    if (identical(this, other)) return true;

    return other.size == size && other.color == color;
  }

  @override
  int get hashCode => size.hashCode ^ color.hashCode;
}

class Cart {
  final int id;
  final String name;
  final int product_id;
  final int status;
  final String brand;
  final String? sell_off;
  final int price_off;
  final int price;
  final String image_url;
  // final ExtraProduct extra_product;
  ProductSize size;
  ProductColor color;
  final List<ProductSize> sizes;
  final List<ProductColor> colors;
  int quantity;

  Cart({
    required this.id,
    required this.name,
    required this.product_id,
    required this.status,
    required this.brand,
    this.sell_off,
    required this.price_off,
    required this.price,
    required this.image_url,
    required this.size,
    required this.color,
    required this.sizes,
    required this.colors,
    required this.quantity,
  });

  Cart copyWith({
    int? id,
    String? name,
    int? product_id,
    int? status,
    String? brand,
    String? sell_off,
    int? price_off,
    int? price,
    String? image_url,
    ProductSize? size,
    ProductColor? color,
    List<ProductSize>? sizes,
    List<ProductColor>? colors,
    int? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      name: name ?? this.name,
      product_id: product_id ?? this.product_id,
      status: status ?? this.status,
      brand: brand ?? this.brand,
      sell_off: sell_off ?? this.sell_off,
      price_off: price_off ?? this.price_off,
      price: price ?? this.price,
      image_url: image_url ?? this.image_url,
      size: size ?? this.size,
      color: color ?? this.color,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toOrderProduct() {
    return <String, dynamic>{
      'product_id': product_id,
      'price': price,
      'quantity': quantity,
      'extra_product': {
        'size': size.id,
        'color': color.id,
      }
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'product_id': product_id,
      'status': status,
      'brand': brand,
      'sell_off': sell_off,
      'price_off': price_off,
      'price': price,
      'image_url': image_url,
      'size': size.toMap(),
      'color': color.toMap(),
      'sizes': sizes.map((x) => x.toMap()).toList(),
      'colors': colors.map((x) => x.toMap()).toList(),
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as int,
      name: map['name'] as String,
      product_id: map['product_id'] as int,
      status: map['status'] as int,
      brand: map['brand'] as String,
      sell_off: map['sell_off'] != null ? map['sell_off'] as String : null,
      price_off: map['price_off'] as int,
      price: map['price'] as int,
      image_url: map['image_url'] as String,
      size: ProductSize.fromMap(map['size'] as Map<String, dynamic>),
      color: ProductColor.fromMap(map['color'] as Map<String, dynamic>),
      sizes: List<ProductSize>.from(
        (map['sizes'] as List).map<ProductSize>(
          (x) => ProductSize.fromMap(x as Map<String, dynamic>),
        ),
      ),
      colors: List<ProductColor>.from(
        (map['colors'] as List).map<ProductColor>(
          (x) => ProductColor.fromMap(x as Map<String, dynamic>),
        ),
      ),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(id: $id, name: $name, product_id: $product_id, status: $status, brand: $brand, sell_off: $sell_off, price_off: $price_off, price: $price, image_url: $image_url, size: $size, color: $color, sizes: $sizes, colors: $colors, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.product_id == product_id &&
        other.status == status &&
        other.brand == brand &&
        other.sell_off == sell_off &&
        other.price_off == price_off &&
        other.price == price &&
        other.image_url == image_url &&
        other.size == size &&
        other.color == color &&
        listEquals(other.sizes, sizes) &&
        listEquals(other.colors, colors) &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        product_id.hashCode ^
        status.hashCode ^
        brand.hashCode ^
        sell_off.hashCode ^
        price_off.hashCode ^
        price.hashCode ^
        image_url.hashCode ^
        size.hashCode ^
        color.hashCode ^
        sizes.hashCode ^
        colors.hashCode ^
        quantity.hashCode;
  }
}
