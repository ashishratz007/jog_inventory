import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class PoOrderModel extends BaseModel{
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
    var resp =  await PoOrderModel().get();
    if(resp.data is Map){
      items = ((resp.data['data']  ??[]) as List).map((json)=> PoOrderModel.fromJson(json)).toList();
    }
    return items;
  }


}