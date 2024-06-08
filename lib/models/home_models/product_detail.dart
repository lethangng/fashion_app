// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'color_model.dart';
import 'size_model.dart';

class ProductDetail {
  final int id;
  final String name;
  final int status;
  final int newest;
  final String brand;
  final String? sell_off;
  final int? price_off;
  final int price;
  final String image_url;
  final List<String> list_image_url;
  final String category;
  final List<SizeModel> sizes;
  final List<ColorModel> colors;
  final bool favorite;
  final int count_evaluate;
  final int average_evaluate;
  final int sold;
  final String? desc;

  ProductDetail({
    required this.id,
    required this.name,
    required this.status,
    required this.newest,
    required this.brand,
    this.sell_off,
    this.price_off,
    required this.price,
    required this.image_url,
    required this.list_image_url,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.favorite,
    required this.count_evaluate,
    required this.average_evaluate,
    required this.sold,
    this.desc,
  });

  ProductDetail copyWith({
    int? id,
    String? name,
    int? status,
    int? newest,
    String? brand,
    String? sell_off,
    int? price_off,
    int? price,
    String? image_url,
    List<String>? list_image_url,
    String? category,
    List<SizeModel>? sizes,
    List<ColorModel>? colors,
    bool? favorite,
    int? count_evaluate,
    int? average_evaluate,
    int? sold,
    String? desc,
  }) {
    return ProductDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      newest: newest ?? this.newest,
      brand: brand ?? this.brand,
      sell_off: sell_off ?? this.sell_off,
      price_off: price_off ?? this.price_off,
      price: price ?? this.price,
      image_url: image_url ?? this.image_url,
      list_image_url: list_image_url ?? this.list_image_url,
      category: category ?? this.category,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      favorite: favorite ?? this.favorite,
      count_evaluate: count_evaluate ?? this.count_evaluate,
      average_evaluate: average_evaluate ?? this.average_evaluate,
      sold: sold ?? this.sold,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'newest': newest,
      'brand': brand,
      'sell_off': sell_off,
      'price_off': price_off,
      'price': price,
      'image_url': image_url,
      'list_image_url': list_image_url,
      'category': category,
      'sizes': sizes.map((x) => x.toMap()).toList(),
      'colors': colors.map((x) => x.toMap()).toList(),
      'favorite': favorite,
      'count_evaluate': count_evaluate,
      'average_evaluate': average_evaluate,
      'sold': sold,
      'desc': desc,
    };
  }

  // list_image_url: map['list_image_url']?.cast<String>(),

  factory ProductDetail.fromMap(Map<String, dynamic> map) {
    return ProductDetail(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      newest: map['newest'] as int,
      brand: map['brand'] as String,
      sell_off: map['sell_off'] != null ? map['sell_off'] as String : null,
      price_off: map['price_off'] != null ? map['price_off'] as int : null,
      price: map['price'] as int,
      image_url: map['image_url'] as String,
      list_image_url: map['list_image_url']?.cast<String>(),
      category: map['category'] as String,
      sizes: List<SizeModel>.from(
        (map['sizes'] as List).map<SizeModel>(
          (x) => SizeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      colors: List<ColorModel>.from(
        (map['colors'] as List).map<ColorModel>(
          (x) => ColorModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      favorite: map['favorite'] as bool,
      count_evaluate: map['count_evaluate'] as int,
      average_evaluate: map['average_evaluate'] as int,
      sold: map['sold'] as int,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetail.fromJson(String source) =>
      ProductDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductDetail(id: $id, name: $name, status: $status, newest: $newest, brand: $brand, sell_off: $sell_off, price_off: $price_off, price: $price, image_url: $image_url, list_image_url: $list_image_url, category: $category, sizes: $sizes, colors: $colors, favorite: $favorite, count_evaluate: $count_evaluate, average_evaluate: $average_evaluate, sold: $sold, desc: $desc)';
  }

  @override
  bool operator ==(covariant ProductDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.status == status &&
        other.newest == newest &&
        other.brand == brand &&
        other.sell_off == sell_off &&
        other.price_off == price_off &&
        other.price == price &&
        other.image_url == image_url &&
        listEquals(other.list_image_url, list_image_url) &&
        other.category == category &&
        listEquals(other.sizes, sizes) &&
        listEquals(other.colors, colors) &&
        other.favorite == favorite &&
        other.count_evaluate == count_evaluate &&
        other.average_evaluate == average_evaluate &&
        other.sold == sold &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        status.hashCode ^
        newest.hashCode ^
        brand.hashCode ^
        sell_off.hashCode ^
        price_off.hashCode ^
        price.hashCode ^
        image_url.hashCode ^
        list_image_url.hashCode ^
        category.hashCode ^
        sizes.hashCode ^
        colors.hashCode ^
        favorite.hashCode ^
        count_evaluate.hashCode ^
        average_evaluate.hashCode ^
        sold.hashCode ^
        desc.hashCode;
  }
}
