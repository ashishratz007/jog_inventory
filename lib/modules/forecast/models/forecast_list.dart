import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/base_model/common_model.dart';
import 'package:jog_inventory/common/utils/utils.dart';
import 'package:jog_inventory/modules/forecast/models/detail.dart';

class ForecastListModel extends BaseModel{
  @override
  String get endPoint => "/api/listForecast";


  static Future<Pagination<ForecastItem>> fetchAll(int page,String? search)async{
    Pagination<ForecastItem> pagination;
    var resp = await ForecastListModel().create(queryParameters: {
      "page":page,
      if(!stringActions.isNullOrEmpty(search))"search":page,

    });
    var items = ParseData.toList<ForecastItem>(resp.data['data'], itemBuilder: (json)=>ForecastItem.fromJson(json));
    pagination = Pagination.fromJson(resp.data, itm: items);
    return pagination;
  }

  static Future<ForecastDetail> fetch(String id)async{
    var url = "/api/forecast-by-id";
    var resp = await ForecastListModel().create(data: {"forecast_id":id},isFormData: true,url: url);
    return ForecastDetail.fromJson(resp.data);
  }
}


class ForecastItem {
  int? rowNumber;
  String? forecastOrder;
  String? forecastDate;
  String? type;
  String? catCode;
  String? color;
  String? balance;
  int? used;
  int? forecastId;
  String? background;

  ForecastItem({
    this.rowNumber,
    this.forecastOrder,
    this.forecastDate,
    this.type,
    this.catCode,
    this.color,
    this.balance,
    this.used,
    this.forecastId,
    this.background,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      rowNumber: ParseData.toInt(json['row_number']),
      forecastOrder: ParseData.string(json['forecast_order']),
      forecastDate: ParseData.string(json['forecast_date']),
      type: ParseData.string(json['type']),
      catCode: ParseData.string(json['cat_code']),
      color: ParseData.string(json['color']),
      balance: ParseData.string(json['balance']), // Assuming 'balance' is a string
      used: ParseData.toInt(json['used']),
      forecastId: ParseData.toInt(json['forecast_id']),
      background: ParseData.string(json['background']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_number'] = rowNumber;
    data['forecast_order'] = forecastOrder;
    data['forecast_date'] = forecastDate;
    data['type'] = type;
    data['cat_code'] = catCode;
    data['color'] = color;
    data['balance'] = balance;
    data['used'] = used;
    data['forecast_id'] = forecastId;
    data['background'] = background;
    return data;
  }
}