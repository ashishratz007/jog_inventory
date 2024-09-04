import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/base_model/common_model.dart';

import '../../../common/exports/main_export.dart';

class NoCodeRQUsedItemModel extends BaseModel {
  @override
  String get endPoint => "/api/draw-by-id";

  int? usedDetailId;
  int? usedId;
  int? materialsId;
  int? typeId;
  int? catId;
  String? usedDetailColor;
  String? usedDetailNo;
  String? usedDetailSize;
  String? catName;
  int? usedDetailUsed;
  int? usedDetailUnitType;
  int? usedDetailPrice;
  int? usedDetailTotal;

  NoCodeRQUsedItemModel({
    this.usedDetailId,
    this.usedId,
    this.materialsId,
    this.typeId,
    this.catId,
    this.usedDetailColor,
    this.usedDetailNo,
    this.usedDetailSize,
    this.usedDetailUsed,
    this.usedDetailUnitType,
    this.usedDetailPrice,
    this.usedDetailTotal,
    this.catName,
  });

  // Assuming ParseData class with static parsing methods is available
  factory NoCodeRQUsedItemModel.fromJson(Map<String, dynamic> json) {
    return NoCodeRQUsedItemModel(
      usedDetailId: ParseData.toInt(json['used_detail_id']),
      usedId: ParseData.toInt(json['used_id']),
      materialsId: ParseData.toInt(json['materials_id']),
      typeId: ParseData.toInt(json['type_id']),
      catId: ParseData.toInt(json['cat_id']),
      usedDetailColor: ParseData.string(json['used_detail_color']),
      usedDetailNo: ParseData.string(json['used_detail_no']),
      usedDetailSize: ParseData.string(json['used_detail_size']),
      catName: ParseData.string(json['cat_name_en']),
      usedDetailUsed: ParseData.toInt(json['used_detail_used']),
      usedDetailUnitType: ParseData.toInt(json['used_detail_unit_type']),
      usedDetailPrice: ParseData.toInt(json['used_detail_price']),
      usedDetailTotal: ParseData.toInt(json['used_detail_total']),
    );
  }

  // Optional toJson method if you need to serialize the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'used_detail_id': usedDetailId,
      'used_id': usedId,
      'materials_id': materialsId,
      'type_id': typeId,
      'cat_id': catId,
      'used_detail_color': usedDetailColor,
      'used_detail_no': usedDetailNo,
      'used_detail_size': usedDetailSize,
      'used_detail_used': usedDetailUsed,
      'used_detail_unit_type': usedDetailUnitType,
      'used_detail_price': usedDetailPrice,
      'used_detail_total': usedDetailTotal,
      'cat_name_en': catName,
    };
  }

  /// get all items for used code
  static Future<List<NoCodeRQUsedItemModel>> fetchAll(String used_Id) async {
    List<NoCodeRQUsedItemModel> items = [];
    var resp = await NoCodeRQUsedItemModel()
        .create(data: {"used_id": used_Id}, isFormData: true);
    resp.data['data']
        .forEach((json) => items.add(NoCodeRQUsedItemModel.fromJson(json)));
    return items;
  }

  /// get all items for used code
  Future deleteItem() async {
    var url = '/api/draw-delete';
    return await NoCodeRQUsedItemModel().create(
      data: {
        "used_id": this.usedId,
        "used_detail_id": this.usedDetailId,
      },
      isFormData: true,
      url: url,
    );
  }
}

class NoCodeRQItemModel extends BaseModel {
  @override
  String get endPoint => "/api/draw";

  int? usedId;
  String? usedCode;
  String? usedOrderCode;
  String? noOrderNote;
  int? usedTotal;
  DateTime? usedDate;
  int? usedUser;
  DateTime? usedUpdate;
  int? usedUpdateUser;

  NoCodeRQItemModel({
    this.usedId,
    this.usedCode,
    this.usedOrderCode,
    this.noOrderNote,
    this.usedTotal,
    this.usedDate,
    this.usedUser,
    this.usedUpdate,
    this.usedUpdateUser,
  });

  // Assuming ParseData class with static parsing methods is available
  factory NoCodeRQItemModel.fromJson(Map<String, dynamic> json) {
    return NoCodeRQItemModel(
      usedId: ParseData.toInt(json['used_id']),
      usedCode: ParseData.string(json['used_code']),
      usedOrderCode: ParseData.string(json['used_order_code']),
      noOrderNote: ParseData.string(json['no_order_note']),
      usedTotal: ParseData.toInt(json['used_total']),
      usedDate: ParseData.toDateTime(json['used_date']),
      usedUser: ParseData.toInt(json['used_user']),
      usedUpdate: ParseData.toDateTime(json['used_update']),
      usedUpdateUser: ParseData.toInt(json['used_update_user']),
    );
  }

  // Optional toJson method if you need to serialize the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'used_id': usedId,
      'used_code': usedCode,
      'used_order_code': usedOrderCode,
      'no_order_note': noOrderNote,
      'used_total': usedTotal,
      'used_date': usedDate?.toIso8601String(),
      'used_user': usedUser,
      'used_update': usedUpdate?.toIso8601String(),
      'used_update_user': usedUpdateUser,
    };
  }

  static Future<Pagination<NoCodeRQItemModel>> fetchAll({String? search, int page = 1}) async {
    List<NoCodeRQItemModel> items = [];
    var resp = await NoCodeRQItemModel().create(data: {
      if(search != null)"search": search,
      "page": page,

    }, isFormData: true);
    resp.data['data']
        .forEach((json) => items.add(NoCodeRQItemModel.fromJson(json)));
    var paginated = Pagination<NoCodeRQItemModel>.fromJson(resp.data);
    paginated.items = items;
    return paginated;
  }
}

class NoCodeDataSummaryModel extends BaseModel {
  @override
  String get endPoint => "/api/draw-summary";

  String? totalCost;
  String? year;
  int? status;
  List<NoCodeSummaryItem>? data;
  String? message;

  NoCodeDataSummaryModel({
    this.totalCost,
    this.year,
    this.data,
    this.status,
    this.message,
  });

  // Assuming ParseData class with static parsing methods is available
  factory NoCodeDataSummaryModel.fromJson(Map<String, dynamic> json) {
    return NoCodeDataSummaryModel(
      totalCost: ParseData.string(json['total_cost']),
      data: ParseData.toList<NoCodeSummaryItem>(json['monthly_data'],
          itemBuilder: (e) => NoCodeSummaryItem.fromJson(e)),
      year: ParseData.string(json['year']),
      status: ParseData.toInt(json['status']),
      message: ParseData.string(json['message']),
    );
  }

  static Future<NoCodeDataSummaryModel> fetchData(String year) async {
    var resp = await NoCodeDataSummaryModel().create(data: {
      "year": year,
    }, isFormData: true);
   return NoCodeDataSummaryModel.fromJson(resp.data);
  }
}

class NoCodeSummaryItem {
  String? month;
  double? usedKg;
  double? cost;

  NoCodeSummaryItem({this.month, this.usedKg, this.cost});

  factory NoCodeSummaryItem.fromJson(Map<String, dynamic> json) {
    return NoCodeSummaryItem(
      month: ParseData.string(json['month']),
      usedKg: ParseData.toDouble(json['used_kg']),
      cost: ParseData.toDouble(json['cost']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'used_kg': usedKg,
      'cost': cost,
    };
  }
}
