// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final int id;
  final String image;
  final String name;
  final int star;
  final int evaluate;
  final String typeProduct;
  final int price;
  final int? salePrice;
  final int? percent;
  final bool? isNew;
  final bool isOutOfStock;
  final void Function()? event;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.star,
    required this.evaluate,
    required this.typeProduct,
    required this.price,
    this.salePrice,
    this.percent,
    this.isNew,
    required this.isOutOfStock,
    this.event,
  });
}
