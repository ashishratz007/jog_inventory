import '../../../common/base_model/base_model.dart';
import '../../../common/utils/utils.dart';

class AssetModel extends BaseModel {
  @override
  String get endPoint => "/api/assets-detail";

  int? id;
  String? assetName;
  int? qty;
  String? department;
  String? cost; // Assuming "Cost" is a string due to quotes
  String? assetCode;
  String? catName;
  String? suppliersName;
  String? assetsLocation;
  String? purchasedDate;
  int? status;

  AssetModel({
    this.id,
    this.assetName,
    this.qty,
    this.department,
    this.cost,
    this.assetCode,
    this.catName,
    this.suppliersName,
    this.assetsLocation,
    this.purchasedDate,
    this.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: ParseData.toInt(json['id']),
      assetName: ParseData.string(json['asset_name']),
      qty: ParseData.toInt(json['qty']),
      department: ParseData.string(json['department']),
      cost: ParseData.string(json['Cost']), // Parsing "Cost" as a string
      assetCode: ParseData.string(json['asset_code']),
      catName: ParseData.string(json['cat_name']),
      suppliersName: ParseData.string(json['suppliers_name']),
      assetsLocation: ParseData.string(json['assets_location']),
      purchasedDate: ParseData.string(json['purchased_date']),
      status: ParseData.toInt(json['status']),
    );
  }

  static Future<AssetModel?> fetch(assetId) async {
    AssetModel? data;
    var resp = await AssetModel().create(isFormData: true,data: {"assets_id": assetId});
    if (resp.data is Map) {
      data = AssetModel.fromJson(resp.data['data']);
    }
    return data;
  }
}
