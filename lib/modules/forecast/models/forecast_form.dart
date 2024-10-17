import 'package:jog_inventory/common/base_model/base_model.dart';

class ForecastFormModel extends BaseModel {
  @override
  String get endPoint => "/api/addForecast";

  String? forecast_id;
  String? forecastCode;
  String? forecastOrder;
  String? forecastDate;
  List<String>? rowUsed;
  List<String>? rowTypeId;
  List<String>? rowCatId;
  List<String>? rowSelectColorId;
  List<String>? rowSelectColor;
  List<String>? rowUnit;

  ForecastFormModel({
    this.forecastCode,
    this.forecast_id,
    this.forecastOrder,
    this.forecastDate,
    this.rowUsed,
    this.rowTypeId,
    this.rowCatId,
    this.rowSelectColorId,
    this.rowSelectColor,
    this.rowUnit,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forecast_id != null) data['forecast_id'] = forecast_id;
    if (forecast_id != null) data['forecast_code'] = forecastCode;
    if (forecastOrder != null) data['forecast_order'] = forecastOrder;
    if (forecastDate != null) data['forecast_date'] = forecastDate;
    data['row_used'] = rowUsed;
    data['row_type_id'] = rowTypeId;
    data['row_cat_id'] = rowCatId;
    data['row_select_color_id'] = rowSelectColorId;
    data['row_select_color'] = rowSelectColor;
    data['row_unit'] = rowUnit;
    return data;
  }

  Future updateData() async {
    var url = "/api/update-forecast";
    return await create(url: url);
  }
}
