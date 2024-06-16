// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../home_models/brand.dart';
import '../home_models/category.dart';
import '../home_models/product_color.dart';
import '../home_models/product_size.dart';

class Filters {
  final int id;
  final String title;
  final String? colorValue;
  final int? minPrice;
  final int? maxPrice;
  bool isSelect;

  Filters({
    required this.id,
    required this.title,
    this.colorValue,
    this.minPrice,
    this.maxPrice,
    required this.isSelect,
  });

  factory Filters.brandToFilter(Brand brand) {
    return Filters(
      id: brand.id,
      title: brand.name,
      isSelect: false,
    );
  }
  factory Filters.colorToFilter(ProductColor colorModel) {
    return Filters(
      id: colorModel.id,
      title: colorModel.name,
      colorValue: colorModel.color,
      isSelect: false,
    );
  }

  factory Filters.sizeToFilter(ProductSize sizeModel) {
    return Filters(
      id: sizeModel.id,
      title: sizeModel.size,
      isSelect: false,
    );
  }

  factory Filters.categoryToFilter(Category category) {
    return Filters(
      id: category.id,
      title: category.name,
      isSelect: false,
    );
  }
}
