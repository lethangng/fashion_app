class ProductModel {
  final int id;
  final String image;
  final String name;
  final int star;
  final String typeProduct;
  final int price;
  final int? salePrice;
  final int? percent;
  final void Function()? event;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.star,
    required this.typeProduct,
    required this.price,
    this.salePrice,
    this.event,
    this.percent,
  });
}
