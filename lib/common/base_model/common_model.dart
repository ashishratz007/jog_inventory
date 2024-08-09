

import 'package:jog_inventory/common/utils/utils.dart';

class Pagination<T> {
  int totalItems;
  int currentPage;
  int pageSize;
  int totalPages;
  bool get hasNext => currentPage < totalPages;

  List<T> items = [];
  Pagination({
    required this.totalItems,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
  });

// From JSON
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: ParseData.toInt(json['total_items']) ?? 0,
      currentPage: ParseData.toInt(json['current_page']) ?? 0,
      pageSize: ParseData.toInt(json['page_size']) ?? 0,
      totalPages: ParseData.toInt(json['total_pages']) ?? 0,
    );
  }
}
