import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final int id;
  final String name;
  final int status;
  final int newest;
  final String brand;
  final String sell_off;
  final int price_off;
  final int price;
  final String image_url;
  final bool favorite;

  Product({
    required this.id,
    required this.name,
    required this.status,
    required this.newest,
    required this.brand,
    required this.sell_off,
    required this.price_off,
    required this.price,
    required this.image_url,
    required this.favorite,
  });

  Product copyWith({
    int? id,
    String? name,
    int? status,
    int? newest,
    String? brand,
    String? sell_off,
    int? price_off,
    int? price,
    String? image_url,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      newest: newest ?? this.newest,
      brand: brand ?? this.brand,
      sell_off: sell_off ?? this.sell_off,
      price_off: price_off ?? this.price_off,
      price: price ?? this.price,
      image_url: image_url ?? this.image_url,
      favorite: favorite ?? this.favorite,
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
      'favorite': favorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      newest: map['newest'] as int,
      brand: map['brand'] as String,
      sell_off: map['sell_off'] as String,
      price_off: map['price_off'] as int,
      price: map['price'] as int,
      image_url: map['image_url'] as String,
      favorite: map['favorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, status: $status, newest: $newest, brand: $brand, sell_off: $sell_off, price_off: $price_off, price: $price, image_url: $image_url, favorite: $favorite)';
  }

  @override
  bool operator ==(covariant Product other) {
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
        other.favorite == favorite;
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
        favorite.hashCode;
  }
}
