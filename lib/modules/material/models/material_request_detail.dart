import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/exports/common.dart';

class MaterialRequestDetail extends BaseModel {
  @override
  String get endPoint => "/api/getbarcode/${fabId}/${pacId}'";

  String fabId; /// fabric id

  String? pacId; /// package id

  MaterialRequestDetail(this.fabId, this.pacId);

  static Future<ScanDetailsModal> getDetails(String fabId, String? pacId) async {
    var resp = await MaterialRequestDetail(fabId, pacId).get();
    if(resp.data is Map)
    return ScanDetailsModal.fromJson(resp.data);
    else {
      throw "No Data Found.";
    }
  }

}

class ScanDetailsModal {
  Data? data;
  String? message;
  int? status;

  ScanDetailsModal({this.data, this.message, this.status});

  ScanDetailsModal.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Data {
  Fabric? fabric;
  var packing;

  Data({this.fabric, this.packing});

  Data.fromJson(Map<String, dynamic> json) {
    fabric =
    json['fabric'] != null ? Fabric.fromJson(json['fabric']) : null;
    packing = json['packing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fabric != null) {
      data['fabric'] = fabric!.toJson();
    }
    data['packing'] = packing;
    return data;
  }
}

class Fabric {
  int? fabricId;
  int? poId;
  dynamic receiptId;
  SupplierId? supplierId;
  CatId? catId;
  int? colorId;
  String? fabricColor;
  String? fabricNo;
  String? fabricBox;
  double? fabricInPiece;
  int? fabricTypeUnit;
  double? fabricInPrice;
  dynamic fabricInTotal;
  dynamic fabricUsed;
  String? fabricAdjust;
  double? fabricBalance;
  dynamic fabricTotal;
  double? fabricAmount;
  String? fabricDateCreate;
  int? fabricUserCreate;
  String? fabricDateUpdate;
  int? fabricUserUpdate;
  int? onProducing;
  int? newForm;

  Fabric(
      {this.fabricId,
        this.poId,
        this.receiptId,
        this.supplierId,
        this.catId,
        this.colorId,
        this.fabricColor,
        this.fabricNo,
        this.fabricBox,
        this.fabricInPiece,
        this.fabricTypeUnit,
        this.fabricInPrice,
        this.fabricInTotal,
        this.fabricUsed,
        this.fabricAdjust,
        this.fabricBalance,
        this.fabricTotal,
        this.fabricAmount,
        this.fabricDateCreate,
        this.fabricUserCreate,
        this.fabricDateUpdate,
        this.fabricUserUpdate,
        this.onProducing,
        this.newForm});

  Fabric.fromJson(Map<String, dynamic> json) {
    fabricId = json['fabric_id'];
    poId = json['po_id'];
    receiptId = json['receipt_id'];
    supplierId = json['supplier_id'] != null
        ? SupplierId.fromJson(json['supplier_id'])
        : null;
    catId = json['cat_id'] != null ? CatId.fromJson(json['cat_id']) : null;
    colorId = json['color_id'];
    fabricColor = json['fabric_color'];
    fabricNo = json['fabric_no'];
    fabricBox = json['fabric_box'];
    fabricInPiece = ParseData.toDouble(json['fabric_in_piece']);
    fabricTypeUnit = json['fabric_type_unit'];
    fabricInPrice = ParseData.toDouble(json['fabric_in_price']);
    fabricInTotal = json['fabric_in_total'];
    fabricUsed = json['fabric_used'];
    fabricAdjust = json['fabric_adjust'];
    fabricBalance = ParseData.toDouble(json['fabric_balance']);
    fabricTotal = json['fabric_total'];
    fabricAmount = ParseData.toDouble(json['fabric_amount']);
    fabricDateCreate = json['fabric_date_create'];
    fabricUserCreate = json['fabric_user_create'];
    fabricDateUpdate = json['fabric_date_update'];
    fabricUserUpdate = json['fabric_user_update'];
    onProducing = json['on_producing'];
    newForm = json['new_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fabric_id'] = fabricId;
    data['po_id'] = poId;
    data['receipt_id'] = receiptId;
    if (supplierId != null) {
      data['supplier_id'] = supplierId!.toJson();
    }
    if (catId != null) {
      data['cat_id'] = catId!.toJson();
    }
    data['color_id'] = colorId;
    data['fabric_color'] = fabricColor;
    data['fabric_no'] = fabricNo;
    data['fabric_box'] = fabricBox;
    data['fabric_in_piece'] = fabricInPiece;
    data['fabric_type_unit'] = fabricTypeUnit;
    data['fabric_in_price'] = fabricInPrice;
    data['fabric_in_total'] = fabricInTotal;
    data['fabric_used'] = fabricUsed;
    data['fabric_adjust'] = fabricAdjust;
    data['fabric_balance'] = fabricBalance;
    data['fabric_total'] = fabricTotal;
    data['fabric_amount'] = fabricAmount;
    data['fabric_date_create'] = fabricDateCreate;
    data['fabric_user_create'] = fabricUserCreate;
    data['fabric_date_update'] = fabricDateUpdate;
    data['fabric_user_update'] = fabricUserUpdate;
    data['on_producing'] = onProducing;
    data['new_form'] = newForm;
    return data;
  }
}

class SupplierId {
  int? supplierId;
  String? supplierCode;
  String? supplierName;
  String? supplierAddress;

  SupplierId(
      {this.supplierId,
        this.supplierCode,
        this.supplierName,
        this.supplierAddress});

  SupplierId.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    supplierCode = json['supplier_code'];
    supplierName = json['supplier_name'];
    supplierAddress = json['supplier_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['supplier_id'] = supplierId;
    data['supplier_code'] = supplierCode;
    data['supplier_name'] = supplierName;
    data['supplier_address'] = supplierAddress;
    return data;
  }
}

class CatId {
  int? catId;
  int? typeId;
  String? catCode;
  String? catNameEn;
  String? catNameTh;
  int? enable;

  CatId(
      {this.catId,
        this.typeId,
        this.catCode,
        this.catNameEn,
        this.catNameTh,
        this.enable});

  CatId.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    typeId = json['type_id'];
    catCode = json['cat_code'];
    catNameEn = json['cat_name_en'];
    catNameTh = json['cat_name_th'];
    enable = json['enable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['type_id'] = typeId;
    data['cat_code'] = catCode;
    data['cat_name_en'] = catNameEn;
    data['cat_name_th'] = catNameTh;
    data['enable'] = enable;
    return data;
  }
}
