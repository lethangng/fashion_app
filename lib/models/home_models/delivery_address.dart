// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeliveryAddress {
  final int id;
  String fullname;
  String phone_number;
  //  String city;
  String address;
  int is_select;

  DeliveryAddress({
    required this.id,
    required this.fullname,
    required this.phone_number,
    required this.address,
    required this.is_select,
  });

  DeliveryAddress copyWith({
    int? id,
    String? fullname,
    String? phone_number,
    String? address,
    int? is_select,
  }) {
    return DeliveryAddress(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      phone_number: phone_number ?? this.phone_number,
      address: address ?? this.address,
      is_select: is_select ?? this.is_select,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'phone_number': phone_number,
      'address': address,
      'is_select': is_select,
    };
  }

  factory DeliveryAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryAddress(
      id: map['id'] as int,
      fullname: map['fullname'] as String,
      phone_number: map['phone_number'] as String,
      address: map['address'] as String,
      is_select: map['is_select'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryAddress.fromJson(String source) =>
      DeliveryAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryAddress(id: $id, fullname: $fullname, phone_number: $phone_number, address: $address, is_select: $is_select)';
  }

  @override
  bool operator ==(covariant DeliveryAddress other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullname == fullname &&
        other.phone_number == phone_number &&
        other.address == address &&
        other.is_select == is_select;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        phone_number.hashCode ^
        address.hashCode ^
        is_select.hashCode;
  }
}
