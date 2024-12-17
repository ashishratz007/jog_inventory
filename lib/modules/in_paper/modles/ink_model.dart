import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/base_model/common_model.dart';

import '../../../common/exports/main_export.dart';

class InkModel extends BaseModel {
  @override
  String get endPoint => "api/ink-list";

  int? id;
  String? supplier;
  String? po;
  String? imSupplier;
  String? inkColor;
  String? rollNo;
  String? inStockMl;
  String? priceLb;
  String? usedMl;
  String? inkBalanceMl;
  String? receiptDate;
  String? usedDate;
  String? usedValue;
  String? inkType;
  String? createYear;
  String? createMonth;
  int? status;

  InkModel({
    this.id,
    this.supplier,
    this.po,
    this.imSupplier,
    this.inkColor,
    this.rollNo,
    this.inStockMl,
    this.priceLb,
    this.usedMl,
    this.inkBalanceMl,
    this.receiptDate,
    this.usedDate,
    this.usedValue,
    this.inkType,
    this.createYear,
    this.createMonth,
    this.status,
  });

  factory InkModel.fromJson(Map<String, dynamic> json) {
    return InkModel(
      id: ParseData.toInt(json['id']),
      supplier: ParseData.string(json['supplier']),
      po: ParseData.string(json['PO']),
      imSupplier: ParseData.string(json['IMsupplier']),
      inkColor: ParseData.string(json['ink_color']),
      rollNo: ParseData.string(json['roll_no']),
      inStockMl: ParseData.string(json['in_stock_ml']),
      priceLb: ParseData.string(json['price_lb']),
      usedMl: ParseData.string(json['used_ML']),
      inkBalanceMl: ParseData.string(json['ink_balance_ML']),
      receiptDate: ParseData.string(json['receipt_date']),
      usedDate: ParseData.string(json['used_date']),
      usedValue: ParseData.string(json['used_value']),
      inkType: ParseData.string(json['ink_type']),
      createYear: ParseData.string(json['create_year']),
      createMonth: ParseData.string(json['create_month']),
      status: ParseData.toInt(json['status']),
    );
  }

  static Future updateInk({
    required String color,
    required String month,
    required String used,
    required List<int> appendIds,
    required DateTime usedDate,
  }) {
    var endpoint = "api/ink-cut-stock";
    var data = {
      "tablename": "ink",
      if(!stringActions.isNullOrEmpty(color))"color": color,
      if(!stringActions.isNullOrEmpty(month))"month": month,
      "appended_ids": "$appendIds",
      "Used": "$used",
      "Ink_Balance": "0",
      "used_date": "${usedDate.year}-${usedDate.month}-${usedDate.day}"
    };
    return InkModel().create(data: data, url: endpoint);
  }

  /// get list
  static Future<Pagination<InkModel>> fetchAll(
    int page, {
    String? stockMl,
    String? month,
    String? year,
    String? color,
  }) async {
    Pagination<InkModel> paginated;
    // filters for the request
    Map<String, dynamic>? data = {
      "stock_ml": stockMl,
      "month": month,
      "year": year,
      "color": color,
    };
    var resp = await InkModel().create(data: data, isFormData: true);
    paginated = Pagination.fromJson(resp.data,
        itm: ParseData.toList(resp.data['data'],
            itemBuilder: (json) => InkModel.fromJson(json)));
    return paginated;
  }
}
