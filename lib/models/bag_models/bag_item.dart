// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'product.dart';

class BagItem {
  final int id;
  final Product product;
  ProductColor selectColor;
  ProductSize selectSize;
  int count;

  BagItem({
    required this.id,
    required this.product,
    required this.selectColor,
    required this.selectSize,
    required this.count,
  });
}
