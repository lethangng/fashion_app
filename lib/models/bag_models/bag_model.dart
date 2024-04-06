// ignore_for_file: public_member_api_docs, sort_constructors_first
class BagModel {
  final int id;
  final String image;
  final String name;
  final String color;
  final String size;
  final int price;
  final String productType;
  int count;

  BagModel({
    required this.id,
    required this.image,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.productType,
    required this.count,
  });
}
