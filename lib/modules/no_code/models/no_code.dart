import 'package:jog_inventory/common/base_model/base_model.dart';

class NoCodeRequestModel extends BaseModel {
  @override
  String get endPoint => "/api/add-draw";

  String? used_code;
  String select_order = "no-code";
  String? used_date;
  String? no_order_note;

  NoCodeRequestModel(
      {this.used_code,
      this.no_order_note,
      this.select_order = "no-code",
      this.used_date});

  Map<String, dynamic> toJson() {
    return {
      'used_code': used_code,
      'select_order': select_order,
      'used_date': used_date,
      'no_order_note': no_order_note,
    };
  }

  static Future addItems(
    List<String> fabric_ids,
    String used_id,
    String cat_id,
  ) async {
    var url = "/api/draw-detail-add";
    return await NoCodeRequestModel().create(
      url: url,
      data: {
        'type_id': 1,
        'fabric_id': fabric_ids.join(","),
        'used_id': used_id,
        'cat_id': cat_id,
      },
      isFormData: true,
    );
  }
}

