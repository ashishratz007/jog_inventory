import 'package:jog_inventory/common/base_model/base_model.dart';

class DigitalPaperRowDataModel extends BaseModel {
  @override
  String get endPoint => "api/paper-add";

  List<String>? receiptDate;
  List<String>? supplier;
  List<String>? po;
  List<String>? imSupplier;
  List<String>? rollNo;
  List<String>? inStock;
  List<String>? priceLb;
  List<String>? priceYads;
  List<String>? usedYads;
  List<String>? paperBalance;
  List<String>? usedValue;
  List<String>? paperSize;
  String? year;
  String? month;

  DigitalPaperRowDataModel({
    this.receiptDate,
    this.supplier,
    this.po,
    this.imSupplier,
    this.rollNo,
    this.inStock,
    this.priceLb,
    this.priceYads,
    this.usedYads,
    this.paperBalance,
    this.usedValue,
    this.paperSize,
    this.year,
    this.month,
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receipt_date'] = receiptDate;
    data['supplier'] = supplier;
    data['PO'] = po;
    data['IMsupplier'] = imSupplier;
    data['roll_no'] = rollNo;
    data['in_stock'] = inStock;
    data['price_lb'] = priceLb;
    data['price_yads'] = priceYads;
    data['used_yads'] = usedYads;
    data['paper_balance'] = paperBalance;
    data['used_value'] = usedValue;
    data['paper_size'] = paperSize;
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}

/// for the api request
class InkRowDataModel extends BaseModel {
  @override
  String get endPoint => "api/ink-add";


  List<String>? receiptDate;
  List<String>? supplier;
  List<String>? po;
  List<String>? imSupplier;
  List<String>? inkColor;
  List<String>? rollNo;
  List<String>? inStockMl;
  List<String>? priceLb;
  List<String>? usedMl;
  List<String>? inkBalanceMl;
  List<String>? used;
  int? year;
  int? month;

  InkRowDataModel({
    this.receiptDate,
    this.supplier,
    this.po,
    this.imSupplier,
    this.inkColor,
    this.rollNo,
    this.inStockMl,
    this.priceLb,
    this.usedMl,
    this.inkBalanceMl,
    this.used,
    this.year,
    this.month,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receipt_date'] = receiptDate;
    data['supplier'] = supplier;
    data['PO'] = po;
    data['IMsupplier'] = imSupplier;
    data['ink_color'] = inkColor;
    data['roll_no'] = rollNo?.map((item)=> int.parse(item)).toList();
    data['in_stock_ml'] = inStockMl?.map((item)=> double.parse(item)).toList();
    data['price_lb'] = priceLb?.map((item)=> double.parse(item)).toList();
    data['used_ML'] = usedMl?.map((item)=> double.parse(item)).toList();
    data['ink_balance_ML'] = inkBalanceMl?.map((item)=> double.parse(item)).toList();
    data['Used'] = used?.map((item)=> double.parse(item)).toList();
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}

/// only to hold data
class InkRowDataItem {
  String? receiptDate;
  String? supplier;
  String? po;
  String? imSupplier;
  String? inkColor;
  int? rollNo;
  int? inStockMl;
  int? priceLb;
  String? usedMl;
  String? inkBalanceMl;
  String? used;
  String? usedDate;
  int? year;
  int? month;

  InkRowDataItem({
    this.receiptDate,
    this.supplier,
    this.po,
    this.imSupplier,
    this.inkColor,
    this.rollNo,
    this.inStockMl,
    this.priceLb,
    this.usedMl,
    this.inkBalanceMl,
    this.usedDate,
    this.used,
    this.year,
    this.month,
});
}

class DigitalPaperRowData {
  String? receiptDate;
   String? supplier;
  String? po;
  String? imSupplier;
  String? rollNo;
  String? inStock;
  String? priceLb;
  String? priceYads;
  String? usedYads;
  String? paperBalance;
  String? usedDate;
  String? usedValue;
  String? paperSize;
  String? year;
  String? month;

  DigitalPaperRowData({
    this.receiptDate,
    this.supplier,
    this.po,
    this.imSupplier,
    this.rollNo,
    this.inStock,
    this.priceLb,
    this.priceYads,
    this.usedYads,
    this.paperBalance,
    this.usedValue,
    this.paperSize,
    this.usedDate,
    this.year,
    this.month,
  });
}
