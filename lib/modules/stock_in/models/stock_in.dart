import 'package:jog_inventory/modules/material/models/fabric.dart';

class StockInFormItem {
  FabricCategoryModel material;
  FabricColorModel color;
  int? box;
  int no;
  double? amount;
  double? unitPrice;
  double get  total => (amount??0) * (unitPrice??0);
  StockInFormItem(
      {required this.material,
      required this.color,
       this.box,
      required this.no,
       this.amount,
      required this.unitPrice});
}
