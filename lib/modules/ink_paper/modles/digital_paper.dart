import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/base_model/common_model.dart';
import '../../../common/exports/main_export.dart';

class DigitalPaperModel extends BaseModel {
  @override
  String get endPoint => "api/paper-list";

  int? id;
  String? supplier;
  String? po;
  String? imSupplier;
  String? rollNo;
  String? inStock;
  String? priceLb;
  String? priceYads;
  String? usedYads;
  String? paperBalance;
  String? receiptDate;
  String? usedDate;
  String? usedValue;
  String? inkType;
  String? paperSize;
  String? createYear;
  String? createMonth;
  int? status;

  DigitalPaperModel({
    this.id,
    this.supplier,
    this.po,
    this.imSupplier,
    this.rollNo,
    this.inStock,
    this.priceLb,
    this.priceYads,
    this.usedYads,
    this.paperBalance,
    this.receiptDate,
    this.usedDate,
    this.usedValue,
    this.inkType,
    this.paperSize,
    this.createYear,
    this.createMonth,
    this.status,
  });

  factory DigitalPaperModel.fromJson(Map<String, dynamic> json) {
    return DigitalPaperModel(
      id: ParseData.toInt(json['id']),
      supplier: ParseData.string(json['supplier']),
      po: ParseData.string(json['PO']),
      imSupplier: ParseData.string(json['IMsupplier']),
      rollNo: ParseData.string(json['roll_no']),
      inStock: ParseData.string(json['in_stock']),
      priceLb: ParseData.string(json['price_lb']),
      priceYads: ParseData.string(json['price_yads']),
      usedYads: ParseData.string(json['used_yads']),
      paperBalance: ParseData.string(json['paper_balance']),
      receiptDate: ParseData.string(json['receipt_date']),
      usedDate: ParseData.string(json['used_date']),
      usedValue: ParseData.string(json['used_value']),
      inkType: ParseData.string(json['ink_type']),
      paperSize: ParseData.string(json['paper_size']),
      createYear: ParseData.string(json['create_year']),
      createMonth: ParseData.string(json['create_month']),
      status: ParseData.toInt(json['status']),
    );
  }

  static Future deletePaper({required List<int> appendIds}) {
    var endpoint = "api/paper-delete";
    var data = {"appended_ids": appendIds};
    return DigitalPaperModel().create(data: data, url: endpoint);
  }

  static Future updatePaper({
    required String size,
    required String month,
    required String year,
    required String used,
    required List<int> appendIds,
    required DateTime usedDate,
  }) {
    var endpoint = "api/paper-cut-stock";
    var data = {
      if (!stringActions.isNullOrEmpty(size)) "paper_size": size,
      if (!stringActions.isNullOrEmpty(month)) "month": month,
      "appended_ids": [829],
      "Used": used,
      "Paper_Balance": 0,
      "used_date": "${usedDate.year}-${usedDate.month}-${usedDate.day}"
    };
    return DigitalPaperModel().create(data: data, url: endpoint);
  }

  static Future<DigitalPaperModel> getPaperDetail(
      {required String paper_id}) async {
    var endpoint = "api/paper-detail";
    var data = {
      "paper_id": paper_id,
    };
    var resp = await DigitalPaperModel().create(data: data, url: endpoint);
    return DigitalPaperModel.fromJson(resp.data['data']);
  }

  static Future<Pagination<DigitalPaperModel>> fetchAll(
    int page, {
    String? paper_size,
    String? month,
    String? year,
    String? IMsupplier,
  }) async {
    Pagination<DigitalPaperModel> paginated;
    // filters for the request
    Map<String, dynamic>? data = {
      "paper_size": paper_size,
      "month": month,
      "year": year,
      "IMsupplier": IMsupplier,
    };
    var qp = {
      "page": page,
    };
    var resp = await DigitalPaperModel()
        .create(data: data, isFormData: true, queryParameters: qp);
    paginated = Pagination.fromJson(resp.data,
        itm: ParseData.toList(resp.data['data'],
            itemBuilder: (json) => DigitalPaperModel.fromJson(json)));
    return paginated;
  }
}

class StockDataModel extends BaseModel {
  @override
  // TODO: implement endPoint
  String get endPoint => "api/paper-size-stock";

  String? paperSize;
  String? createMonth;
  String? createYear;
  String? balanceCount;
  String? unusedCount;

  StockDataModel({
    this.paperSize,
    this.createMonth,
    this.createYear,
    this.balanceCount,
    this.unusedCount,
  });

  factory StockDataModel.fromJson(Map<String, dynamic> json) {
    return StockDataModel(
      paperSize: ParseData.string(json['paper_size']),
      createMonth: ParseData.string(json['create_month']),
      createYear: ParseData.string(json['create_year']),
      balanceCount: ParseData.string(json['balance_count']),
      unusedCount: ParseData.string(json['unused_count']),
    );
  }

  static Future<List<StockDataModel>> getStock(
      {String? year, String? month}) async {
    List<StockDataModel> stockData = [];
    var qp = {"IMsupplier": "Digital", "month": month, "year": year};
    var resp = await StockDataModel().create(queryParameters: qp,data: {});
    stockData = ParseData.toList<StockDataModel>(resp.data['data'],
        itemBuilder: (json) => StockDataModel.fromJson(json));
    return stockData;
  }
}
