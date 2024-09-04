

import 'package:jog_inventory/common/utils/utils.dart';

class Pagination<T> {
  int totalItems;
  int currentPage;
  int pageSize;
  int totalPages;
  int get length => items.length;
  bool get hasNext => currentPage < totalPages;
  clear(){
    items.clear();
  }

  List<T> items = [];
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    List<T>? items
  }): this.items = items??[];

// From JSON
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: ParseData.toInt(json['total_items']??json['total']??json['total_records']) ?? 0,
      currentPage: ParseData.toInt(json['current_page']) ?? 0,
      pageSize: ParseData.toInt(json['page_size']) ?? 0,
      totalPages: ParseData.toInt(json['total_pages']??json['last_page']) ?? 0,
    );
  }
}
