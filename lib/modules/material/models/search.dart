import 'package:jog_inventory/common/base_model/base_model.dart';

import '../../../common/exports/main_export.dart';

class SearchOrderModal extends BaseModel {
  @override
  String get endPoint => 'api/order-title';

  List<SearchData>? data;
  String? message;
  int? status;

  SearchOrderModal({this.data, this.message, this.status});

  SearchOrderModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add(SearchData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }

  static Future<SearchOrderModal> searchData(String query) async {
    var resp = await SearchOrderModal().create(
      queryParameters: {
        'order_code': query,
      },
    );

    return SearchOrderModal.fromJson(resp.data);
  }
}

class SearchData {
  bool? selected = false;
  int? orderLkrTitleId;
  String? orderTitle;
  String? haveOrderForm;
  String? orderName;
  String? orderDetail;
  String? folderName;
  int? toForecast;
  int? toAddOrder;
  int? toProducing;
  String? addDate;
  int? enable;

  SearchData(
      {this.orderLkrTitleId,
      this.orderTitle,
      this.haveOrderForm,
      this.orderName,
      this.orderDetail,
      this.folderName,
      this.toForecast,
      this.toAddOrder,
      this.toProducing,
      this.addDate,
      this.enable});

  SearchData.fromJson(Map<String, dynamic> json) {
    orderLkrTitleId = json['order_lkr_title_id'];
    orderTitle = json['order_title'];
    haveOrderForm = json['have_order_form'];
    orderName = json['order_name'];
    orderDetail = json['order_detail'];
    folderName = json['folder_name'];
    toForecast = json['to_forecast'];
    toAddOrder = json['to_add_order'];
    toProducing = json['to_producing'];
    addDate = json['add_date'];
    enable = json['enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_lkr_title_id'] = orderLkrTitleId;
    data['order_title'] = orderTitle;
    data['have_order_form'] = haveOrderForm;
    data['order_name'] = orderName;
    data['order_detail'] = orderDetail;
    data['folder_name'] = folderName;
    data['to_forecast'] = toForecast;
    data['to_add_order'] = toAddOrder;
    data['to_producing'] = toProducing;
    data['add_date'] = addDate;
    data['enable'] = enable;
    return data;
  }
}


Future<List<DropDownItem<SearchData>>> searchCodesMenuItems(
    String query) async {
  var data = await SearchOrderModal.searchData(query);
  var list = data.data ?? [];
  return List.generate(
      data.data?.length ?? 0,
      (index) => DropDownItem<SearchData>(
          id: index,
          title: list[index].orderTitle ?? "",
          key: list[index].orderTitle ?? "_",
          value: list[index]));
}
