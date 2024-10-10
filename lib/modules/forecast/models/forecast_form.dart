
import 'package:jog_inventory/common/base_model/base_model.dart';

class ForecastFormModel extends BaseModel {
  @override
  String get endPoint => "/api/addForecast";


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
    data['forecast_code'] = forecastCode;
    data['forecast_order'] = forecastOrder;
    data['forecast_date'] = forecastDate;
    data['row_used'] = rowUsed;
    data['row_type_id'] = rowTypeId;
    data['row_cat_id'] = rowCatId;
    data['row_select_color_id'] = rowSelectColorId;
    data['row_select_color'] = rowSelectColor;
    data['row_unit'] = rowUnit;
    return data;
  }
}