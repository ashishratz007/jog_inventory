import '../exports/main_export.dart';

class FilterItem<T> {
  int id;
  String title;
  String key;
  String? description;
  T? value;
  void Function()? onTap;
  bool isSelected;
  FilterItem(
      {required this.id,
      required this.title,
      required this.key,
      this.description,
      this.value,
      this.isSelected = false,
      this.onTap});
}

class DropDownItem<T> {
  int id;
  String title;
  String key;
  String? description;
  void Function()? onTap;
  bool isSelected;
  T? value;
  DropDownItem(
      {required this.id,
      required this.title,
      required this.key,
      this.description,
      this.value,
      this.isSelected = false,
      this.onTap});
}

class MenuItem<T> {
  int id;
  String title;
  Widget? icon;
  String key;
  String? description;
  void Function(T)? onTap;
  bool isSelected;
  T? value;

  MenuItem(
      {required this.id,
      required this.title,
      required this.key,
      this.description,
      this.icon,
      this.value,
      this.isSelected = false,
      this.onTap});
}

/// drawer item

class DrawerItem {
  String title;
  Widget? icon;
  int? count;
  Function() onTap;
  DrawerItem({
    required this.title,
    this.icon,
    this.count,
    required this.onTap,
  });
}