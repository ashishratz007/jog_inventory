
import 'package:jog_inventory/modules/material/models/fabric.dart';

class ForeCastFormItem {
  FabricCategoryModel material;
  FabricColorModel color;
  int? box;
  String? balance ;
  String? forecast;
  ForeCastFormItem(
      {required this.material,
        required this.color,
        this.box,
        this.balance,this.forecast,});
}
