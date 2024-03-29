// ignore_for_file: public_member_api_docs, sort_constructors_first
class FiltersModel {
  int id;
  String title;
  bool isSelect;
  void Function()? event;

  FiltersModel({
    required this.id,
    required this.title,
    required this.isSelect,
    this.event,
  });
}
