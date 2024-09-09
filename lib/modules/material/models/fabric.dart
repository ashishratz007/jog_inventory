import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/common/base_model/common_model.dart';

import '../../../common/exports/main_export.dart';

/// fabric class
class FabricModel extends BaseModel {
  @override
  String get endPoint => "/api/fabrics";

  int? fabricId;
  int? poId;
  int? receiptId;
  int? supplierId;
  int? catId;
  int? colorId;
  String? fabricColor;
  String? fabricNo;
  String? fabricBox;
  int? fabricInPiece;
  int? fabricTypeUnit;
  int? fabricInPrice;
  int? fabricInTotal;
  int? fabricUsed;
  String? fabricAdjust;
  int? fabricBalance;
  int? fabricTotal;
  int? fabricAmount;
  DateTime? fabricDateCreate;
  int? fabricUserCreate;
  DateTime? fabricDateUpdate;
  int? fabricUserUpdate;
  int? onProducing;
  int? newForm;

  FabricModel({
    this.fabricId,
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
    this.newForm,
  });

  // Assuming ParseData class with static parsing methods is available
  factory FabricModel.fromJson(Map<String, dynamic> json) {
    return FabricModel(
      fabricId: ParseData.toInt(json['fabric_id']),
      poId: ParseData.toInt(json['po_id']),
      receiptId: ParseData.toInt(json['receipt_id']),
      supplierId: ParseData.toInt(json['supplier_id']),
      catId: ParseData.toInt(json['cat_id']),
      colorId: ParseData.toInt(json['color_id']),
      fabricColor: ParseData.string(json['fabric_color']),
      fabricNo: ParseData.string(json['fabric_no']),
      fabricBox: ParseData.string(json['fabric_box']),
      fabricInPiece: ParseData.toInt(json['fabric_in_piece']),
      fabricTypeUnit: ParseData.toInt(json['fabric_type_unit']),
      fabricInPrice: ParseData.toInt(json['fabric_in_price']),
      fabricInTotal: ParseData.toInt(json['fabric_in_total']),
      fabricUsed: ParseData.toInt(json['fabric_used']),
      fabricAdjust: ParseData.string(json['fabric_adjust']),
      fabricBalance: ParseData.toInt(json['fabric_balance']),
      fabricTotal: ParseData.toInt(json['fabric_total']),
      fabricAmount: ParseData.toInt(json['fabric_amount']),
      fabricDateCreate: ParseData.toDateTime(json['fabric_date_create']),
      fabricUserCreate: ParseData.toInt(json['fabric_user_create']),
      fabricDateUpdate: ParseData.toDateTime(json['fabric_date_update']),
      fabricUserUpdate: ParseData.toInt(json['fabric_user_update']),
      onProducing: ParseData.toInt(json['on_producing']),
      newForm: ParseData.toInt(json['new_form']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fabric_id': fabricId,
      'po_id': poId,
      'receipt_id': receiptId,
      'supplier_id': supplierId,
      'cat_id': catId,
      'color_id': colorId,
      'fabric_color': fabricColor,
      'fabric_no': fabricNo,
      'fabric_box': fabricBox,
      'fabric_in_piece': fabricInPiece,
      'fabric_type_unit': fabricTypeUnit,
      'fabric_in_price': fabricInPrice,
      'fabric_in_total': fabricInTotal,
      'fabric_used': fabricUsed,
      'fabric_adjust': fabricAdjust,
      'fabric_balance': fabricBalance,
      'fabric_total': fabricTotal,
      'fabric_amount': fabricAmount,
      'fabric_date_create': fabricDateCreate?.toIso8601String(),
      'fabric_user_create': fabricUserCreate,
      'fabric_date_update': fabricDateUpdate?.toIso8601String(),
      'fabric_user_update': fabricUserUpdate,
      'on_producing': onProducing,
      'new_form': newForm,
    };
  }

  static Future<Pagination<FabricModel>> getFabrics() async {
    Pagination<FabricModel> pagination;
    var resp = await FabricModel().get();
    pagination = Pagination.fromJson(resp.data['fabrics']);
    pagination.items = ParseData.toList(resp.data['fabrics']?['data'] ?? [],
        itemBuilder: (json) => FabricModel.fromJson(json));
    return pagination;
  }

  static Future<Pagination<FabricModel>> getFabricsById(String fabricId) async {
    Pagination<FabricModel> pagination;
    var resp = await FabricModel().get(pathSuffix: "${fabricId}");
    pagination = Pagination.fromJson(resp.data['fabrics']);
    pagination.items = ParseData.toList(resp.data['fabrics']?['data'] ?? [],
        itemBuilder: (json) => FabricModel.fromJson(json));
    return pagination;
  }
}

/// fabric category
class FabricCategoryModel extends BaseModel {
  @override
  String get endPoint => "/api/get-cat";

  int? catId;
  int? typeId;
  String? catCode;
  String? catNameEn;
  String? catNameTh;
  int? enable;

  FabricCategoryModel({
    this.catId,
    this.typeId,
    this.catCode,
    this.catNameEn,
    this.catNameTh,
    this.enable,
  });

  // Assuming ParseData class with static parsing methods is available
  factory FabricCategoryModel.fromJson(Map<String, dynamic> json) {
    return FabricCategoryModel(
      catId: ParseData.toInt(json['cat_id']),
      typeId: ParseData.toInt(json['type_id']),
      catCode: ParseData.string(json['cat_code']),
      catNameEn: ParseData.string(json['cat_name_en']),
      catNameTh: ParseData.string(json['cat_name_th']),
      enable: ParseData.toInt(json['enable']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'type_id': typeId,
      'cat_code': catCode,
      'cat_name_en': catNameEn,
      'cat_name_th': catNameTh,
      'enable': enable,
    };
  }

  static Future<List<FabricCategoryModel>> fetchAll() async {
    List<FabricCategoryModel> items = [];
    var resp = await FabricCategoryModel().create();
    items = ParseData.toList(resp.data['data'] ?? [],
        itemBuilder: (json) => FabricCategoryModel.fromJson(json));
    return items;
  }
}

/// fabric colors
class FabricColorModel extends BaseModel {
  @override
  String get endPoint => "/api/get-feb-color";

  String? fabricColor;

  FabricColorModel({this.fabricColor});

  factory FabricColorModel.fromJson(Map<String, dynamic> json) {
    return FabricColorModel(
      fabricColor: json['fabric_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fabric_color': fabricColor,
    };
  }

  static Future<List<FabricColorModel>> getColors(int catId) async {
    var resp =
        await FabricColorModel().create(queryParameters: {'cat_id': catId});
    return ParseData.toList<FabricColorModel>(resp.data['data'],
        itemBuilder: (json) => FabricColorModel.fromJson(json));
  }
}

/// Fabric Boxes
class ColorBoxesModel extends BaseModel {
  @override
  String get endPoint => "/api/get-feb-boxno";

  int? fabricId;
  String? fabricBox;
  String? fabricNo;
  double? fabricBalance;

  String get title => "${fabricBox??""}/${fabricNo ?? ""} (${fabricBalance??0.0} kg.)";

  ColorBoxesModel({
    this.fabricId,
    this.fabricBox,
    this.fabricNo,
    this.fabricBalance,
  });

  factory ColorBoxesModel.fromJson(Map<String, dynamic> json) {
    return ColorBoxesModel(
      fabricId: ParseData.toInt(json['fabric_id']),
      fabricBox: ParseData.string(json['fabric_box']),
      fabricNo: ParseData.string(json['fabric_no']),
      fabricBalance: ParseData.toDouble(json['fabric_balance']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fabric_id': fabricId,
      'fabric_box': fabricBox,
      'fabric_no': fabricNo,
      'fabric_balance': fabricBalance,
    };
  }

  static Future<List<ColorBoxesModel>> fetchBoxes(
      int cartId, String colorName) async {
    List<ColorBoxesModel> boxes = [];
    var resp = await ColorBoxesModel().create(queryParameters: {
      'cat_id': cartId,
      'color_name': colorName,
    });
    if (resp.data is Map) {
      boxes.addAll(ParseData.toList(resp.data['data'],
          itemBuilder: (json) => ColorBoxesModel.fromJson(json)));
    }
    return boxes;
  }
}

class RemoveCodeModel extends BaseModel {
  @override
  String get endPoint => "/api/remove-order";

  List<int> codes = [];
  RemoveCodeModel(this.codes);

  Future removeCodes() async {
    return await this.create(
        isFormData: true, data: {'order_lk': codes.join(",").toString()});
  }
}

class FabricTypeModel extends BaseModel {
  @override
  String get endPoint => "/api/get-type";

  int? catId;
  String? catNameEn;

  FabricTypeModel({this.catId, this.catNameEn});

  // Assuming ParseData class with static parsing methods is available
  factory FabricTypeModel.fromJson(Map<String, dynamic> json) {
    return FabricTypeModel(
      catId: ParseData.toInt(json['cat_id']),
      catNameEn: ParseData.string(json['cat_name_en']),
    );
  }

  // Optional toJson method if you need to serialize the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'cat_id': catId,
      'cat_name_en': catNameEn,
    };
  }

  static Future<List<FabricTypeModel>> fetchAll() async {
    List<FabricTypeModel> fabricTypes = [];
    var resp = await FabricTypeModel().create(queryParameters: {"type_id": 1});
    resp.data['data'].forEach((json) {
      fabricTypes.add(FabricTypeModel.fromJson(json));
    });

    return fabricTypes;
  }
}

class TypeCategoryModel extends BaseModel {
  @override
  String get endPoint => "/api/get-type-cat";
  DateTime? fabricDateCreate;
  String? catNameEn;
  String? fabricColor;
  String? fabricNo;
  String? fabricBox;
  String? fabricBalance;
  int? fabricUsed;
  int? fabricAmount;
  int? fabricId;
  String? catId;
  String? typeId;

  TypeCategoryModel({
    this.fabricDateCreate,
    this.catNameEn,
    this.fabricColor,
    this.fabricNo,
    this.fabricBox,
    this.fabricBalance,
    this.fabricUsed,
    this.fabricAmount,
    this.fabricId,
    this.catId,
    this.typeId,
  });

  factory TypeCategoryModel.fromJson(Map<String, dynamic> json) {
    return TypeCategoryModel(
      fabricDateCreate: ParseData.toDateTime(json['fabric_date_create']),
      catNameEn: ParseData.string(json['cat_name_en']),
      fabricColor: ParseData.string(json['fabric_color']),
      fabricNo: ParseData.string(json['fabric_no']),
      fabricBox: ParseData.string(json['fabric_box']),
      fabricBalance: ParseData.string(json['fabric_balance']),
      fabricUsed: ParseData.toInt(json['fabric_used']),
      fabricAmount: ParseData.toInt(json['fabric_amount']),
      fabricId: ParseData.toInt(json['fabric_id']),
      catId: ParseData.string(json['cat_id']),
      typeId: ParseData.string(json['type_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fabric_date_create': fabricDateCreate?.toIso8601String(),
      'cat_name_en': catNameEn,
      'fabric_color': fabricColor,
      'fabric_no': fabricNo,
      'fabric_box': fabricBox,
      'fabric_balance': fabricBalance,
      'fabric_used': fabricUsed,
      'fabric_amount': fabricAmount,
      'fabric_id': fabricId,
      'cat_id': catId,
      'type_id': typeId,
    };
  }

  static Future<List<TypeCategoryModel>> fetchAll(String cat_id) async {
    List<TypeCategoryModel> fabricTypes = [];
    var resp = await TypeCategoryModel().create(queryParameters: {
      "type_id": 1,
      "cat_id": cat_id,
    }, data: {});
    resp.data['data'].forEach((json) {
      fabricTypes.add(TypeCategoryModel.fromJson(json));
    });

    return fabricTypes;
  }
}
