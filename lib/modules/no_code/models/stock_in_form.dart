import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/modules/stock_in/models/stock_in.dart';

class StockInFormModel extends BaseModel {
  @override
  String get endPoint => "/api/addstock";

  int forId;
  String poDate;
  int supplierId;
  String supplierName;
  String newInvNo;
  String stockDate;
  List<StockInFormItem> items;

  StockInFormModel({
    required this.forId,
    required this.poDate,
    required this.supplierId,
    required this.supplierName,
    required this.newInvNo,
    required this.stockDate,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'for_id': forId,
      'po_date': poDate,
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'new_inv_no': newInvNo,
      'stock_date': stockDate,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  static Future check(StockInFormModel model){
    return model.create();
  }
}

class ReceivedModel extends BaseModel {
  @override
  String get endPoint => "/api/set-receive";

  Future received(String forItemId, String valReceived) {
    return this.create(data: {"for_item_id":forItemId,"val_receive":valReceived ,},isFormData: true);
  }

}