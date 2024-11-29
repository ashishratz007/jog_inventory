import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/utils/utils.dart';

class StockInYearlyDataModel extends BaseModel {
  @override
  // TODO: implement endPoint
  String get endPoint => "/api/stock-statistics";

  String? year;
  Map<String, MonthDataModel>? data;
  String? total;

  StockInYearlyDataModel({this.year, this.data, this.total});

  factory StockInYearlyDataModel.fromJson(Map<String, dynamic> json) {
    return StockInYearlyDataModel(
      year: json['year'] as String?,
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          MonthDataModel.fromJson(value as Map<String, dynamic>, key),
        ),
      ),
      total: json['total'] as String?,
    );
  }

  static Future<StockInYearlyDataModel> fetchAll(String year) async {
    var resp = await StockInYearlyDataModel().get(queryParameters: {"y": year});
    return StockInYearlyDataModel.fromJson(resp.data);
  }
}

class MonthDataModel {
  double? sumTotal;
  double? sumRecieve;
  String? yearMonth;

  MonthDataModel({this.sumTotal, this.sumRecieve, this.yearMonth});

  factory MonthDataModel.fromJson(Map<String, dynamic> json,String year) {
    return MonthDataModel(
      sumTotal: ParseData.toDouble(json['sum_total']),
      sumRecieve: ParseData.toDouble(json['sum_recieve']),
      yearMonth: year,
    );
  }
}


class SetInvoiceModel extends BaseModel{
  @override
  String get endPoint => "/api/update-invoice";

  String invoice;
  String pac_id;
  SetInvoiceModel({
    required this.invoice,
   required this.pac_id,
  });


  @override
  Map<String, dynamic> toJson() {
   return  {
     "pac_id":pac_id,
     "new_inv_no":invoice,
    };
  }

}

class SetAmountModel extends BaseModel{
  @override
  String get endPoint => "/api/update-unitprice";

  String fabric_id_list;
  String new_unit_price;
  SetAmountModel({
    required this.fabric_id_list,
   required this.new_unit_price,
  });


  @override
  Map<String, dynamic> toJson() {
   return  {
     "new_unit_price":new_unit_price,
     "fabric_id_list":fabric_id_list,
    };
  }

}