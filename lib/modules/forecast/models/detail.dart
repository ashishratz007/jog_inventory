import 'package:jog_inventory/modules/forecast/models/forecast_item.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';

import '../../../common/exports/main_export.dart';

class ForecastDetail {
  List<ForecastData> data;
  List<ForeCastFormItem> get forecastItems => ParseData.toList<ForeCastFormItem>(data, itemBuilder: (item)=> item.clone());
  List<ForecastHead> forecastHead;
  String? message;
  int? status;

  ForecastDetail({
    this.data = const [],
    this.forecastHead = const [],
    this.message,
    this.status,
  });

  factory ForecastDetail.fromJson(Map<String, dynamic> json) {
    return ForecastDetail(
      data: ParseData.toList<ForecastData>(json['data'], itemBuilder: (i) => ForecastData.fromJson(i)),
      forecastHead: ParseData.toList<ForecastHead>(json['forecast_head'], itemBuilder: (i) => ForecastHead.fromJson(i)),
      message: ParseData.string(json['message']),
      status: ParseData.toInt(json['status']),
    );
  }
}

class ForecastData {
  int? forecastDetailId;
  int? forecastId;
  int? typeId;
  int? catId;
  int? colorId;
  String? forecastDetailColor;
  double? forecastDetailUsed;
  int? forecastDetailUnitType;
  String? catNameEn;
  String? fabricBal;

  ForecastData({
    this.forecastDetailId,
    this.forecastId,
    this.typeId,
    this.catId,
    this.colorId,
    this.forecastDetailColor,
    this.forecastDetailUsed,
    this.forecastDetailUnitType,
    this.catNameEn,
    this.fabricBal,
  });

  ForeCastFormItem clone() => ForeCastFormItem(
    color: FabricColorModel(fabricColor: forecastDetailColor,color_id: colorId.toString()),
    material: FabricCategoryModel(catId:catId ,catCode: catNameEn,catNameEn:catNameEn ,catNameTh:catNameEn ,enable:1 ,typeId: typeId,),
    box: 0,
    balance: fabricBal,
    forecast: forecastDetailUsed.toString(),
  );

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      forecastDetailId: ParseData.toInt(json['forecast_detail_id']),
      forecastId: ParseData.toInt(json['forecast_id']),
      typeId: ParseData.toInt(json['type_id']),
      catId: ParseData.toInt(json['cat_id']),
      colorId: ParseData.toInt(json['color_id']),
      forecastDetailColor: ParseData.string(json['forecast_detail_color']),
      forecastDetailUsed: ParseData.toDouble(json['forecast_detail_used']),
      forecastDetailUnitType: ParseData.toInt(json['forecast_detail_unit_type']),
      catNameEn: ParseData.string(json['cat_name_en']),
      fabricBal: ParseData.string(json['fabric_balance']),
    );
  }
}

class ForecastHead {
  int? forecastId;
  String? forecastCode;
  String? forecastOrder;
  double? forecastTotal;
  String? forecastDate;
  String? forecastUser;
  String? forecastUpdate;
  int? forecastUpdateUser;
  bool? isProduced;

  ForecastHead({
    this.forecastId,
    this.forecastCode,
    this.forecastOrder,
    this.forecastTotal,
    this.forecastDate,
    this.forecastUser,
    this.forecastUpdate,
    this.forecastUpdateUser,
    this.isProduced = false,
  });

  factory ForecastHead.fromJson(Map<String, dynamic> json) {
    return ForecastHead(
      forecastId: ParseData.toInt(json['forecast_id']),
      forecastCode: ParseData.string(json['forecast_code']),
      forecastOrder: ParseData.string(json['forecast_order']),
      forecastTotal: ParseData.toDouble(json['forecast_total']),
      forecastDate: ParseData.string(json['forecast_date']),
      forecastUser: ParseData.string(json['forecast_user']),
      forecastUpdate: ParseData.string(json['forecast_update']),
      forecastUpdateUser: ParseData.toInt(json['forecast_update_user']),
      isProduced: ParseData.toBool(json['is_produced']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forecast_id'] = forecastId;
    data['forecast_code'] = forecastCode;
    data['forecast_order'] = forecastOrder;
    data['forecast_total'] = forecastTotal;
    data['forecast_date'] = forecastDate;
    data['forecast_user'] = forecastUser;
    data['forecast_update'] = forecastUpdate;
    data['forecast_update_user'] = forecastUpdateUser;
    data['is_produced'] = isProduced;
    return data;
  }
}