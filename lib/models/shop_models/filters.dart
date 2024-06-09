// ignore_for_file: public_member_api_docs, sort_constructors_first
class Filters {
  final int id;
  final String title;
  final String? colorValue;
  bool isSelect;

  Filters({
    required this.id,
    required this.title,
    this.colorValue,
    required this.isSelect,
  });
}
