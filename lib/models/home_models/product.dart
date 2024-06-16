import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final int id;
  final String name;
  final int status;
  final int newest;
  final String brand;
  final String? sell_off;
  final int? price_off;
  final int price;
  final String image_url;
  final bool favorite;
  final int count_evaluate;
  final int average_evaluate;

  Product({
    required this.id,
    required this.name,
    required this.status,
    required this.newest,
    required this.brand,
    required this.sell_off,
    this.price_off,
    required this.price,
    required this.image_url,
    required this.favorite,
    required this.count_evaluate,
    required this.average_evaluate,
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
    int? count_evaluate,
    int? average_evaluate,
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
      count_evaluate: count_evaluate ?? this.count_evaluate,
      average_evaluate: average_evaluate ?? this.average_evaluate,
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
      'count_evaluate': count_evaluate,
      'average_evaluate': average_evaluate,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      newest: map['newest'] as int,
      brand: map['brand'] as String,
      sell_off: map['sell_off'] != null ? map['sell_off'] as String : null,
      price_off: map['price_off'] != null ? map['price_off'] as int : null,
      price: map['price'] as int,
      image_url: map['image_url'] as String,
      favorite: map['favorite'] as bool,
      count_evaluate: map['count_evaluate'] as int,
      average_evaluate: map['average_evaluate'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, status: $status, newest: $newest, brand: $brand, sell_off: $sell_off, price_off: $price_off, price: $price, image_url: $image_url, favorite: $favorite, count_evaluate: $count_evaluate, average_evaluate: $average_evaluate)';
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
        other.favorite == favorite &&
        other.count_evaluate == count_evaluate &&
        other.average_evaluate == average_evaluate;
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
        favorite.hashCode ^
        count_evaluate.hashCode ^
        average_evaluate.hashCode;
  }
}
