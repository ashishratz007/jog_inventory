import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class MaterialRequestModal extends BaseModel {
  @override
  String get endPoint => "/api/material-request-list";

  int? rqId;
  int? orderLkrTitleId;
  String? orderCode;
  int? isAddon;
  DateTime? rqDate;
  String? rqStatus;
  DateTime? finishDate;
  int? employeeId;
  int? enable;
  String? employeeName;

  MaterialRequestModal({
    this.rqId,
    this.orderLkrTitleId,
    this.orderCode,
    this.isAddon,
    this.rqDate,
    this.rqStatus,
    this.finishDate,
    this.employeeId,
    this.enable,
    this.employeeName,
  });

  factory MaterialRequestModal.fromJson(Map<String, dynamic> json) {
    return MaterialRequestModal(
      rqId: ParseData.toInt(json['rq_id']),
      orderLkrTitleId: ParseData.toInt(json['order_lkr_title_id']),
      orderCode: ParseData.string(json['order_code']),
      isAddon: ParseData.toInt(json['is_addon']),
      rqDate: ParseData.toDateTime(json['rq_date']),
      rqStatus: ParseData.string(json['rq_status']),
      finishDate: ParseData.toDateTime(json['finish_date']),
      employeeId: ParseData.toInt(json['employee_id']),
      enable: ParseData.toInt(json['enable']),
      employeeName: ParseData.string(json['employee_name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rq_id': rqId,
      'order_lkr_title_id': orderLkrTitleId,
      'order_code': orderCode,
      'is_addon': isAddon,
      'rq_date': rqDate?.toIso8601String(), // Convert DateTime to string
      'rq_status': rqStatus,
      'finish_date':
          finishDate?.toIso8601String(), // Convert DateTime to string
      'employee_id': employeeId,
      'enable': enable,
      'employee_name': employeeName,
    };
  }

  static Future<List<MaterialRequestModal>> getMaterialRequest() async {
    List<MaterialRequestModal> list = [];
    var resp = await MaterialRequestModal().get();

    if (resp.data is Map && resp.data['data'] is List) {
      list = ParseData.toList<MaterialRequestModal>(resp.data['data'],
          itemBuilder: (json) => MaterialRequestModal.fromJson(json));
    }
    return list;
  }
}

