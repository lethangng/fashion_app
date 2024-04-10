// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand {
  final int id;
  final String brand;
  final String? desc;

  Brand({
    required this.id,
    required this.brand,
    this.desc,
  });
}

class ProductColor {
  final int id;
  final String? image;
  final String color;

  ProductColor({
    required this.id,
    this.image,
    required this.color,
  });
}

class ProductSize {
  final int id;
  final String size;
  final String? desc;

  ProductSize({
    required this.id,
    required this.size,
    this.desc,
  });
}

class Product {
  final int id;
  final String name;
  final List<String> listImage;
  final String desc;
  final double price;
  final double? priceSale;
  final bool? isNew;
  final List<ProductColor> listColor;
  final List<ProductSize> listSize;
  final List<Brand> listBrand;
  final bool isOutOfStock;

  Product({
    required this.id,
    required this.name,
    required this.listImage,
    required this.desc,
    required this.price,
    this.priceSale,
    this.isNew,
    required this.listColor,
    required this.listSize,
    required this.listBrand,
    required this.isOutOfStock,
  });
}
