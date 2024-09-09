import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';
import 'package:jog_inventory/modules/material/models/material_request.dart';

class MaterialRqFormModel extends BaseModel {
  @override
  String get endPoint => "/api/add-request";
  List<MaterialRQItem> items = [];
  String order_code; // order code
  String? balance_after;
  String? item_note;
  int order_lkr_title_id; // order code id

  MaterialRqFormModel({
    required this.order_code,
    required this.order_lkr_title_id,
    required this.items,
    this.balance_after,
    this.item_note,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'order_code': order_code,
      'order_lkr_title_id': order_lkr_title_id,
      'balance_after': order_lkr_title_id,
      'item_note': item_note,
      'fabric_id_list':
          items.map((item) => item.fabricId!).toList().join(",").toString(),
    };
  }

  Future addForm() async {
    return await this.create(isFormData: true);
  }

  Future submitUpdate({
    required String rqId,
    required List<String> rqItemIds,
    required List<String> fabricIds,
    required List<String> beforeBal,
    required List<String> afterBal,
    required List<String> itemNote,
  }) async {
    var data = {
      "finish_rq_id": rqId,
      "rq_item_id": rqItemIds,
      "fabric_id": fabricIds,
      "before_bal": beforeBal,
      "after_bal": afterBal,
      "item_note": itemNote,
    };
    return await this.create(data: data);
  }
}

class MaterialRQFormItem {
  FabricCategoryModel selectedFabCate;
  FabricColorModel selectedFabColor;
  ColorBoxesModel selectedFabColorBoxes;
  MaterialRQFormItem({
    required this.selectedFabCate,
    required this.selectedFabColorBoxes,
    required this.selectedFabColor,
  });
}

class DeleteMaterialRQModel extends BaseModel {
  @override
  String get endPoint => "/api/disable-request";
  String rq_id;
  DeleteMaterialRQModel({required this.rq_id});

  @override
  Map<String, dynamic> toJson() {
    return {'rq_id': rq_id};
  }
}

class SubmitRQFinishModel extends BaseModel {
  @override
  String get endPoint => "/api/submit-rq-finish";

  String rqId;
  List<String> rqItemIds;
  List<String> fabricIds;
  List<String> beforeBal;
  List<String> afterBal;
  List<String> itemNote;

  SubmitRQFinishModel({
    required this.rqId,
    required this.rqItemIds,
    required this.fabricIds,
    required this.beforeBal,
    required this.afterBal,
    required this.itemNote,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "finish_rq_id": rqId,
      "rq_item_id": rqItemIds,
      "fabric_id": fabricIds,
      "before_bal": beforeBal,
      "after_bal": afterBal,
      "item_note": itemNote,
    };
  }
}
