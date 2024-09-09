import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class MaterialRQDetailModel extends BaseModel {
  @override
  String get endPoint => "/api/get-request-status";

  String? rqStatus;
  String? rqId;
  double? grandUsed;
  double? grandTotal;
  String? fabricIdList;
  List<MaterialRQItemScan>? items;
  String? message;
  int? status;

  MaterialRQDetailModel({
    this.rqStatus,
    this.rqId,
    this.grandUsed,
    this.grandTotal,
    this.fabricIdList,
    this.items,
    this.message,
    this.status,
  });

  factory MaterialRQDetailModel.fromJson(Map<String, dynamic> json) {
    return MaterialRQDetailModel(
      rqStatus: ParseData.string(json['rq_status']),
      rqId: ParseData.string(json['rq_id']),
      grandUsed: ParseData.toDouble(json['grand_used']),
      grandTotal: ParseData.toDouble(json['grand_total']),
      fabricIdList: ParseData.string(json['fabric_id_list']),
      items: (json['items'] as List?)
          ?.map((e) => MaterialRQItemScan.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: ParseData.string(json['message']),
      status: ParseData.toInt(json['status']),
    );
  }

  static Future<MaterialRQDetailModel> fetch(String ethCode) async {
    var resp = await MaterialRQDetailModel().create(data: {"order_lkr_title_id": ethCode}, isFormData: true);
    return MaterialRQDetailModel.fromJson(resp.data);
  }

  static Future  updateRequest(String rq_id, List<String> fabric_id_list)async{
    var url = "/api/saveRQEditing";
    return await MaterialRQDetailModel().create(url: url, data: {
      "rq_id": rq_id,
      "fabric_id_list": fabric_id_list.join(",").toString()
    },isFormData: true);
  }
}

class MaterialRQItemScan {
  String? categoryName;
  String? fabricColor;
  String? fabricBox;
  String? fabricNo;
  double? fabricBalance;
  double? balanceAfter;
  /// TODO
  double get qtyRequested {
    var ttl = 0.0;
    (ParseData.toDouble(fabricBalance)??0.0);
    return 0.0;
  }

  MaterialRQItemActions? actions;

  MaterialRQItemScan({
    this.categoryName,
    this.fabricColor,
    this.fabricBox,
    this.fabricNo,
    this.fabricBalance,
    this.balanceAfter,
    this.actions,
  });

  factory MaterialRQItemScan.fromJson(Map<String, dynamic> json) {
    return MaterialRQItemScan(
      categoryName: ParseData.string(json['category_name']),
      fabricColor: ParseData.string(json['fabric_color']),
      fabricBox: ParseData.string(json['fabric_box']),
      fabricNo: ParseData.string(json['fabric_no']),
      fabricBalance: ParseData.toDouble(json['fabric_balance']),
      balanceAfter: ParseData.toDouble(json['balance_after']),
      actions: json['actions'] != null
          ? MaterialRQItemActions.fromJson(
              json['actions'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MaterialRQItemActions {
  bool? canRemove;
  int? fabricId;
  int? rqItemId;

  MaterialRQItemActions({
    this.canRemove,
    this.fabricId,
    this.rqItemId,
  });

  factory MaterialRQItemActions.fromJson(Map<String, dynamic> json) {
    return MaterialRQItemActions(
      canRemove: ParseData.toBool(json['can_remove']),
      fabricId: ParseData.toInt(json['fabric_id']),
      rqItemId: ParseData.toInt(json['rq_item_id']),
    );
  }
}
