import 'package:jog_inventory/common/utils/bottom_sheet.dart';

import '../../../common/exports/main_export.dart';

void openAddFabricPopup(){
   showAppBottomSheet(Get.context!, _addFabric(),title: "Add Fabric");
}


class _addFabric extends StatefulWidget {
  const _addFabric({super.key});

  @override
  State<_addFabric> createState() => _addFabricState();
}

class _addFabricState extends State<_addFabric> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.pagePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  labelText: "Fabric",
                  onChanged: (item) {},
                ),
              ),
              gap(space: 10),
              Expanded(
                  child:
                  TextFieldWithLabel(labelText: "Color"))
            ],
          ),
          gap(space: 10),
          TextFieldWithLabel(
            labelText: "Unit Price",
            onChanged: (item) {},
          ),
          gap(space: 10),
          Row(
            children: [
              Expanded(
                child: TextFieldWithLabel(
                  labelText: "Rolls",
                  onChanged: (item) {},
                ),
              ),
              gap(space: 10),
              Expanded(
                  child:
                  TextFieldWithLabel(labelText: "Start No."))
            ],
          ),
          gap(space: 10),

          // bottom
          gap(),
          safeAreaBottom(context)
        ],
      ),
    );
  }
}
