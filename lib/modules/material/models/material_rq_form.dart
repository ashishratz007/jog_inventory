import 'package:jog_inventory/common/base_model/base_model.dart';
import 'package:jog_inventory/modules/material/models/fabric.dart';

class MaterialRqFormModel extends BaseModel {
  @override
  String get endPoint => "/api/add-request";
  List<MaterialRQFormItem> items = [];
  String order_code; // order code
  int order_lkr_title_id; // order code id

  MaterialRqFormModel(
      {required this.order_code,
      required this.order_lkr_title_id,
      required this.items});

  @override
  Map<String, dynamic> toJson() {
    return {
      'order_code': order_code,
      'order_lkr_title_id': order_lkr_title_id,
      'fabric_id_list': items
          .map((item) => item.selectedFabColorBoxes.fabricId!)
          .toList()
          .join(",")
          .toString(),
    };
  }

  Future addForm() async {
    return await this.create(isFormData: true);
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
