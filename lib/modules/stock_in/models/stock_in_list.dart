import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class StockInDetailModel extends BaseModel{
  @override
  String get endPoint => "/api/get-packing-details";

  StockPacking? packing;
  List<StockInFabric>? fabrics;
  int? totalPiece;
  int? totalAmount;
  String? message;
  int? status;

  StockInDetailModel({
    this.packing,
    this.fabrics,
    this.totalPiece,
    this.totalAmount,
    this.message,
    this.status,
  });

  factory StockInDetailModel.fromJson(Map<String, dynamic> json) {
    return StockInDetailModel(
      packing: json['packing'] != null
          ? StockPacking.fromJson(json['packing'] as Map<String, dynamic>)
          : null,
      fabrics: (json['fabrics'] as List<dynamic>?)
          ?.map((e) => StockInFabric.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPiece: ParseData.toInt(json['total_piece']),
      totalAmount: ParseData.toInt(json['total_amount']),
      message: ParseData.string(json['message']),
      status: ParseData.toInt(json['status']),
    );
  }


  static Future<StockInDetailModel> fetch(String id)async{
    var resp = await StockInDetailModel().create(data: {'pac_id': id});
    return StockInDetailModel.fromJson(resp.data);
  }
}

class StockPacking {
  int? pacId;
  String? poNo;
  String? invNo;
  int? supplierId;
  String? poDate;
  int? employeeId;
  String? addDate;
  int? enable;
  String? packNo;
  String? supplierName;

  StockPacking({
    this.pacId,
    this.poNo,
    this.invNo,
    this.supplierId,
    this.poDate,
    this.employeeId,
    this.addDate,
    this.enable,
    this.packNo,
    this.supplierName,
  });

  factory StockPacking.fromJson(Map<String, dynamic> json) {
    return StockPacking(
      pacId: ParseData.toInt(json['pac_id']),
      poNo: ParseData.string(json['po_no']),
      invNo: ParseData.string(json['inv_no']),
      supplierId: ParseData.toInt(json['supplier_id']),
      poDate: ParseData.string(json['po_date']),
      employeeId: ParseData.toInt(json['employee_id']),
      addDate: ParseData.string(json['add_date']),
      enable: ParseData.toInt(json['enable']),
      packNo: ParseData.string(json['pack_no']),
      supplierName: ParseData.string(json['supplier_name']),
    );
  }
}

class StockInFabric {
  String? catNameEn;
  String? fabricColor;
  String? fabricBox;
  String? fabricNo;
  int? fabricInPiece;
  double? fabricInPrice;
  double? fabricInTotal;
  double? fabricBalance;
  int? onProducing;
  String? fabric_id;

  StockInFabric({
    this.catNameEn,
    this.fabricColor,
    this.fabricBox,
    this.fabricNo,
    this.fabricInPiece,
    this.fabricInPrice,
    this.fabricInTotal,
    this.fabricBalance,
    this.onProducing,
    this.fabric_id,
  });

  factory StockInFabric.fromJson(Map<String, dynamic> json) {
    return StockInFabric(
      catNameEn: ParseData.string(json['cat_name_en']),
      fabricColor: ParseData.string(json['fabric_color']),
      fabricBox: ParseData.string(json['fabric_box']),
      fabricNo: ParseData.string(json['fabric_no']),
      fabricInPiece: ParseData.toInt(json['fabric_in_piece']),
      fabricInPrice: ParseData.toDouble(json['fabric_in_price']),
      fabric_id: ParseData.string(json['fabric_id']),
      fabricInTotal: ParseData.toDouble(json['fabric_in_total']),
      fabricBalance: ParseData.toDouble(json['fabric_balance']),
      onProducing: ParseData.toInt(json['on_producing']),
    );
  }
}