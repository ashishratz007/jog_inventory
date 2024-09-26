import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class PoOrderModel extends BaseModel {
  @override
  String get endPoint => "/api/po-order";

  int? forId;
  String? poNumber;
  DateTime? poDate;
  String? supplier;
  int? supplierId;
  DateTime? addDate;
  String? poStatus;
  int? enable;

  PoOrderModel({
    this.forId,
    this.poNumber,
    this.poDate,
    this.supplier,
    this.supplierId,
    this.addDate,
    this.poStatus,
    this.enable,
  });

  factory PoOrderModel.fromJson(Map<String, dynamic> json) {
    return PoOrderModel(
      forId: ParseData.toInt(json['for_id']),
      poNumber: ParseData.string(json['po_number']),
      poDate: ParseData.toDateTime(json['po_date']),
      supplier: ParseData.string(json['supplier']),
      supplierId: ParseData.toInt(json['supplier_id']),
      addDate: ParseData.toDateTime(json['add_date']),
      poStatus: ParseData.string(json['po_status']),
      enable: ParseData.toInt(json['enable']),
    );
  }

  static Future<List<PoOrderModel>> fetchAll() async {
    List<PoOrderModel> items = [];
    var resp = await PoOrderModel().get();
    if (resp.data is Map) {
      items = ((resp.data['data'] ?? []) as List)
          .map((json) => PoOrderModel.fromJson(json))
          .toList();
    }
    return items;
  }
}

class ForecastReceivedModel extends BaseModel {
  @override
  String get endPoint => "/api/getfordata";

  int? forItemId;
  int? forId;
  int? catId;
  String? color;
  int? colorId;
  double? qty;
  bool isReceive;
  DateTime? receiveDate;
  String? receiveKg;
  String? catNameEn;

  ForecastReceivedModel({
    this.forItemId,
    this.forId,
    this.catId,
    this.color,
    this.colorId,
    this.qty,
    this.isReceive = false,
    this.receiveDate,
    this.catNameEn,
  });

  factory ForecastReceivedModel.fromJson(Map<String, dynamic> json) {
    return ForecastReceivedModel(
      forItemId: ParseData.toInt(json['for_item_id']),
      forId: ParseData.toInt(json['for_id']),
      catId: ParseData.toInt(json['cat_id']),
      color: ParseData.string(json['color']),
      colorId: ParseData.toInt(json['color_id']),
      qty: ParseData.toDouble(json['qty']),
      isReceive: ParseData.toBool(json['is_receive']),
      receiveDate: ParseData.toDateTime(json['receive_date']),
      catNameEn: ParseData.string(json['cat_name_en']),
    );
  }

  static Future<List<ForecastReceivedModel>> fetchAll(int forId) async {
    List<ForecastReceivedModel> items = [];
    var resp =
        await ForecastReceivedModel().create(data: {"for_id": forId});
    if (resp.data is Map) {
      items = ((resp.data['data'] ?? []) as List)
          .map((json) => ForecastReceivedModel.fromJson(json))
          .toList();
    }
    return items;
  }
}
