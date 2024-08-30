import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class MaterialRequestModel extends BaseModel {
  @override
  String get endPoint => "/api/material-request-list";

  int? rqId;
  String? orderCode;
  DateTime? rqDate;
  DateTime? finishDate;
  int? itemNum;
  String? employeeName;
  String? gUsed;
  int? gTotal;
  int? isAddon;
  String? rqStatus;

  MaterialRequestModel({
    this.rqId,
    this.orderCode,
    this.rqDate,
    this.finishDate,
    this.itemNum,
    this.employeeName,
    this.gUsed,
    this.gTotal,
    this.isAddon,
    this.rqStatus,
  });

  // Assuming ParseData class with static parsing methods is available
  factory MaterialRequestModel.fromJson(Map<String, dynamic> json) {
    return MaterialRequestModel(
      rqId: ParseData.toInt(json['rq_id']),
      orderCode: ParseData.string(json['order_code']),
      rqDate: ParseData.toDateTime(json['rq_date']),
      finishDate: ParseData.toDateTime(json['finish_date']),
      itemNum: ParseData.toInt(json['item_num']),
      employeeName: ParseData.string(json['employee_name']),
      gUsed: ParseData.string(json['g_used']),
      gTotal: ParseData.toInt(json['g_total']),
      isAddon: ParseData.toInt(json['is_addon']),
      rqStatus: ParseData.string(json['rq_status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rq_id': rqId,
      'order_code': orderCode,
      'rq_date': rqDate?.toIso8601String(),
      'finish_date': finishDate?.toIso8601String(),
      'item_num': itemNum,
      'employee_name': employeeName,
      'g_used': gUsed,
      'g_total': gTotal,
      'is_addon': isAddon,
      'rq_status': rqStatus,
    };
  }

  static Future<List<MaterialRequestModel>> fetch(int page,
      {bool isFinished = false}) async {
    List<MaterialRequestModel> list = [];
    var resp = await MaterialRequestModel().create(
      isFormData: true,
      queryParameters: {"page": page},
      data: {"status": isFinished ? "finish" : "producing"},
    );

    if (resp.data is Map && resp.data['data'] is List) {
      list = ParseData.toList<MaterialRequestModel>(resp.data['data'],
          itemBuilder: (json) => MaterialRequestModel.fromJson(json));
    }
    return list;
  }
}

class MaterialRequestDetailModel extends BaseModel {
  @override
  String get endPoint => "/api/material-request";

  List<MaterialRQItem>? orders;
  MaterialRequestDetailModel({this.orders});

  factory MaterialRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return MaterialRequestDetailModel(
        orders: ParseData.toList<MaterialRQItem>(json['Order'],
            itemBuilder: (json) => MaterialRQItem.fromJson(json)));
  }

  static Future<MaterialRequestDetailModel> fetch(int id) async {
    var resp = await MaterialRequestDetailModel().get(pathSuffix: "/${id}");
    return MaterialRequestDetailModel.fromJson(resp.data);
  }
}

class MaterialRQItem {
  int? rqItemId;
  int? rqId;
  int? fabricId;
  String? balanceBefore;
  String? balanceAfter;
  String? used;
  String? itemNote;
  int? markCutStock;
  DateTime? cutDate;
  int? poId;
  int? receiptId;
  int? supplierId;
  int? catId;
  int? colorId;
  String? fabricColor;
  String? fabricNo;
  String? catCode;
  String? fabricBox;
  int? fabricInPiece;
  int? fabricTypeUnit;
  int? fabricInPrice;
  int? fabricInTotal;
  int? fabricUsed;
  String? fabricAdjust;
  double? fabricBalance;
  int? fabricTotal;
  int? fabricAmount;
  DateTime? fabricDateCreate;
  int? fabricUserCreate;
  DateTime? fabricDateUpdate;
  int? fabricUserUpdate;
  int? onProducing;
  int? newForm;
  String? catNameEn;

  MaterialRQItem({
    this.rqItemId,
    this.rqId,
    this.fabricId,
    this.balanceBefore,
    this.balanceAfter,
    this.used,
    this.itemNote,
    this.markCutStock,
    this.cutDate,
    this.poId,
    this.receiptId,
    this.supplierId,
    this.catId,
    this.colorId,
    this.fabricColor,
    this.fabricNo,
    this.fabricBox,
    this.fabricInPiece,
    this.fabricTypeUnit,
    this.fabricInPrice,
    this.fabricInTotal,
    this.catCode,
    this.fabricUsed,
    this.fabricAdjust,
    this.fabricBalance,
    this.fabricTotal,
    this.fabricAmount,
    this.fabricDateCreate,
    this.fabricUserCreate,
    this.fabricDateUpdate,
    this.fabricUserUpdate,
    this.onProducing,
    this.newForm,
    this.catNameEn,
  });

  factory MaterialRQItem.fromJson(Map<String, dynamic> json) {
    return MaterialRQItem(
      rqItemId: ParseData.toInt(json['rq_item_id']),
      rqId: ParseData.toInt(json['rq_id']),
      fabricId: ParseData.toInt(json['fabric_id']),
      balanceBefore: ParseData.string(json['balance_before']),
      balanceAfter: ParseData.string(json['balance_after']),
      used: ParseData.string(json['used']),
      itemNote: ParseData.string(json['item_note']),
      markCutStock: ParseData.toInt(json['mark_cut_stock']),
      cutDate: ParseData.toDateTime(json['cut_date']),
      poId: ParseData.toInt(json['po_id']),
      receiptId: ParseData.toInt(json['receipt_id']),
      supplierId: ParseData.toInt(json['supplier_id']),
      catId: ParseData.toInt(json['cat_id']),
      colorId: ParseData.toInt(json['color_id']),
      catCode: ParseData.string(json['cat_code']),
      fabricColor: ParseData.string(json['fabric_color']),
      fabricNo: ParseData.string(json['fabric_no']),
      fabricBox: ParseData.string(json['fabric_box']),
      fabricInPiece: ParseData.toInt(json['fabric_in_piece']),
      fabricTypeUnit: ParseData.toInt(json['fabric_type_unit']),
      fabricInPrice: ParseData.toInt(json['fabric_in_price']),
      fabricInTotal: ParseData.toInt(json['fabric_in_total']),
      fabricUsed: ParseData.toInt(json['fabric_used']),
      fabricAdjust: ParseData.string(json['fabric_adjust']),
      fabricBalance: ParseData.toDouble(json['fabric_balance']),
      fabricTotal: ParseData.toInt(json['fabric_total']),
      fabricAmount: ParseData.toInt(json['fabric_amount']),
      fabricDateCreate: ParseData.toDateTime(json['fabric_date_create']),
      fabricUserCreate: ParseData.toInt(json['fabric_user_create']),
      fabricDateUpdate: ParseData.toDateTime(json['fabric_date_update']),
      fabricUserUpdate: ParseData.toInt(json['fabric_user_update']),
      onProducing: ParseData.toInt(json['on_producing']),
      newForm: ParseData.toInt(json['new_form']),
      catNameEn: ParseData.string(json['cat_name_en']),
    );
  }
}
