import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class StockInModel extends BaseModel{
  @override
  String get endPoint => "/api/get-stock-list";


  String? receiptId;
  String? poNo;
  String? packNo;
  String? invNo;
  String? supplierName;
  DateTime? receiptDate;
  int? sumPo;
  String? pacId;

  StockInModel({
    this.receiptId,
    this.poNo,
    this.packNo,
    this.invNo,
    this.supplierName,
    this.receiptDate,
    this.sumPo,
    this.pacId,
  });

  factory StockInModel.fromJson(Map<String, dynamic> json) {
    return StockInModel(
      receiptId: ParseData.string(json['receipt_id']),
      poNo: ParseData.string(json['po_no']),
      packNo: ParseData.string(json['pack_no']),
      invNo: ParseData.string(json['inv_no']),
      supplierName: ParseData.string(json['supplier_name']),
      receiptDate: ParseData.toDateTime(json['receipt_date']),
      sumPo: ParseData.toInt(json['sum_po']),
      pacId: ParseData.string(json['pac_id']),
    );
  }

  static Future<List<StockInModel>> fetchAll()async{
    List<StockInModel>  items = [];
    var resp = await StockInModel().create(data: {});
    if(resp.data is Map){
      items =  ParseData.toList<StockInModel>( resp.data['data'], itemBuilder: (json)=> StockInModel.fromJson(json));
    }
    return items;
  }
}